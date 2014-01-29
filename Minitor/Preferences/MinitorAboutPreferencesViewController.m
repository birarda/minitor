//
//  MinitorAboutPreferencesViewController.m
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import "MinitorAboutPreferencesViewController.h"

@implementation MinitorAboutPreferencesViewController

- (id)init {
    return [super initWithNibName:@"MinitorAboutPreferencesView" bundle:nil];
}

#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"About";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameInfo];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"About", @"Toolbar item name for the About preference pane");
}

@end
