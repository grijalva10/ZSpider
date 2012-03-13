//
//  ZSAppDelegate.h
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ZSViewController;

@interface ZSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (nonatomic, strong) NSViewController * controller;

@end
