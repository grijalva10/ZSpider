//
//  ZSAppDelegate.m
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import "ZSAppDelegate.h"

#import "ZSViewController.h"

@implementation ZSAppDelegate

@synthesize window = _window;

@synthesize controller;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.controller = [[ZSViewController alloc] initWithNibName:@"ZSViewController" bundle:nil];
    
    [self.window setContentView:self.controller.view];
}

@end
