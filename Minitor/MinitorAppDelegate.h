//
//  MinitorAppDelegate.h
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MASPreferencesWindowController.h>

@interface MinitorAppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) MASPreferencesWindowController *settingsController;

@end
