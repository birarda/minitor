//
//  MinitorAPISettingsWindowViewController.m
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import "MinitorAppDelegate.h"

#import "MinitorAPIPreferencesWindowViewController.h"

@interface MinitorAPIPreferencesWindowViewController ()
@property (weak) IBOutlet NSTextField *urlTextField;
@property (weak) IBOutlet NSTextField *apiKeyTextField;
@property (weak) IBOutlet NSTextField *userIDTextField;

@end

@implementation MinitorAPIPreferencesWindowViewController

- (id)init {
    return [super initWithNibName:@"MinitorAPIPreferencesView" bundle:nil];
}

- (void)loadView {
    [super loadView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults valueForKey:@"api-url"]) {
        [self.urlTextField setStringValue:[defaults valueForKey:@"api-url"]];
    }
    
    if ([defaults valueForKey:@"api-key"]) {
        [self.apiKeyTextField setStringValue:[defaults valueForKey:@"api-key"]];
    }
    
    if ([defaults valueForKey:@"api-user-id"]) {
        [self.userIDTextField setStringValue:[defaults valueForKey:@"api-user-id"]];
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.urlTextField.stringValue forKey:@"api-url"];
    [defaults setObject:self.apiKeyTextField.stringValue forKey:@"api-key"];
    [defaults setObject:self.userIDTextField.stringValue forKey:@"api-user-id"];
    [defaults synchronize];
    
    [((MinitorAppDelegate *)[[NSApplication sharedApplication] delegate]) refreshStats];
    
    [self.view.window close];
}

#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"APIPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameAdvanced];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"API", @"Toolbar item name for the API preference pane");
}

@end
