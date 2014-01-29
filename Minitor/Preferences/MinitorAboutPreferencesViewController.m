//
//  MinitorAboutPreferencesViewController.m
//  Minitor
//
//  Created by Stephen Birarda on 1/29/2014.
//  Copyright (c) 2014 Stephen Birarda. All rights reserved.
//

#import "HyperlinkTextField.h"

#import "MinitorAboutPreferencesViewController.h"

@interface MinitorAboutPreferencesViewController ()

@property (weak) IBOutlet HyperlinkTextField *githubTextField;

@end

@implementation MinitorAboutPreferencesViewController

- (id)init {
    return [super initWithNibName:@"MinitorAboutPreferencesView" bundle:nil];
}

- (void)loadView {
    [super loadView];
    
    // Create hyperlink
    NSString *linkName = @"https://github.com/birarda/minitor";
    NSURL *url = [NSURL URLWithString:linkName];
    NSMutableAttributedString *hyperlinkString = [[NSMutableAttributedString alloc] initWithString:linkName];
    [hyperlinkString beginEditing];
    [hyperlinkString addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, [hyperlinkString length])];
    [hyperlinkString addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:NSMakeRange(0, [hyperlinkString length])];
    [hyperlinkString endEditing];
    
    [self.githubTextField setAttributedStringValue:hyperlinkString];
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
