//
//  MinitorAPISettingsWindowViewController.m
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import "MinitorAPISettingsWindowViewController.h"

@interface MinitorAPISettingsWindowViewController ()

@end

@implementation MinitorAPISettingsWindowViewController

- (id)init {
    return [super initWithNibName:@"MinitorAPISettingsView" bundle:nil];
}


#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"APISettings";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameUserAccounts];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"API", @"Toolbar item name for the API preference pane");
}

@end
