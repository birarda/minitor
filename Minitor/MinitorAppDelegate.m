//
//  MinitorAppDelegate.m
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

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
    
    [menu addItemWithTitle:@"Payout: 0.00 DOGE" action:nil keyEquivalent:@""];
    [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    
    return menu;
}

- (void)refreshStats {
    NSDictionary *params = @{ @"page": @"api",
                              @"action": @"getdashboarddata",
                              @"api_key": @"API_KEY",
                              @"id": @"USER_ID"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableSet *contentTypes = [manager.responseSerializer.acceptableContentTypes mutableCopy];
    [contentTypes addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    
    [manager GET:@"http://doge.poolerino.com/index.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonResponse = (NSDictionary *)responseObject;
        
        _statusItem.title = [NSString stringWithFormat:@"%@ KH/s", [jsonResponse valueForKeyPath:@"getdashboarddata.data.personal.hashrate"]];
        [[_statusItem.menu itemAtIndex:0] setTitle:[NSString stringWithFormat:@"Payout: %@ DOGE", [jsonResponse valueForKeyPath:@"getdashboarddata.data.personal.estimates.payout"]]];
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
