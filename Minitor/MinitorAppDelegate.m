//
//  MinitorAppDelegate.m
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "MinitorAboutPreferencesViewController.h"
#import "MinitorAPIPreferencesWindowViewController.h"

#import "MinitorAppDelegate.h"

@implementation MinitorAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setupStatusBar];
    
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(refreshStats) userInfo:nil repeats:YES];
    [self refreshStats];
}

- (void)setupStatusBar {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.title = @"0.00 KH/s";
    _statusItem.highlightMode = YES;
    
    _statusItem.menu = [self defaultMenu];
}

- (NSMenu *)defaultMenu {
    NSMenu *menu = [[NSMenu alloc] init];
    
    [menu addItemWithTitle:@"Payout: 0.00" action:nil keyEquivalent:@""];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItemWithTitle:@"Preferences..." action:@selector(openSettings:) keyEquivalent:@""];
    [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    
    return menu;
}

#pragma mark - Actions

- (IBAction)openSettings:(id)sender {
    [self.settingsController showWindow:nil];
}

- (MASPreferencesWindowController *)settingsController {
    if (!_settingsController) {
        NSViewController *apiViewController = [[MinitorAPIPreferencesWindowViewController alloc] init];
        NSViewController *aboutViewController = [[MinitorAboutPreferencesViewController alloc] init];
        NSArray *controllers = @[apiViewController, aboutViewController];
        
        NSString *title = NSLocalizedString(@"Preferences", @"Common title for Preferences window");
        _settingsController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:title];
    }
    return _settingsController;
}

- (void)refreshStats {
    
    // make sure we have a URL, API key, and user ID
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableString *apiURL = [[defaults valueForKey:@"api-url"] mutableCopy];
    NSString *apiKey = [defaults valueForKey:@"api-key"];
    NSString *userID = [defaults valueForKey:@"api-user-id"];
    
    if (apiURL && apiKey && userID) {
        NSDictionary *params = @{ @"page": @"api",
                                  @"action": @"getdashboarddata",
                                  @"api_key": apiKey,
                                  @"id": userID};
        
        if ([apiURL rangeOfString:@"index.php"].length > 0) {
            if (![apiURL hasSuffix:@"/"]) {
                [apiURL appendString:@"/"];
            }
            
            [apiURL appendString:@"index.php"];
        }
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSMutableSet *contentTypes = [manager.responseSerializer.acceptableContentTypes mutableCopy];
        [contentTypes addObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        
        [manager GET:apiURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *jsonResponse = (NSDictionary *)responseObject;
            
            NSDictionary *personalData = [jsonResponse valueForKeyPath:@"getdashboarddata.data.personal"];
            
            if (personalData) {
                NSString *currencyString = [jsonResponse valueForKeyPath:@"getdashboarddata.data.pool.info.currency"];
                _statusItem.title = [NSString stringWithFormat:@"%@ KH/s", [personalData valueForKey:@"hashrate"]];
                [[_statusItem.menu itemAtIndex:0] setTitle:[NSString stringWithFormat:@"Payout: %@%@", [personalData valueForKeyPath:@"estimates.payout"], (currencyString ? [NSString stringWithFormat:@" %@", currencyString] : nil)]];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

#pragma mark -

NSString *const kFocusedAdvancedControlIndex = @"FocusedAdvancedControlIndex";

- (NSInteger)focusedAdvancedControlIndex
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kFocusedAdvancedControlIndex];
}

- (void)setFocusedAdvancedControlIndex:(NSInteger)focusedAdvancedControlIndex
{
    [[NSUserDefaults standardUserDefaults] setInteger:focusedAdvancedControlIndex forKey:kFocusedAdvancedControlIndex];
}

@end
