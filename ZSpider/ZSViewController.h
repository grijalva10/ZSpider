//
//  ZSViewController.h
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ZSURLQueue.h"

@class ZSpider;

@class ZSViewController;

@interface ZSViewController  : NSViewController{

}

@property (strong, nonatomic) IBOutlet NSTextField * urlField;
@property (strong, nonatomic) IBOutlet NSButton * startButton;
@property (strong, nonatomic) IBOutlet NSButton * stopButton;
@property (strong, nonatomic) IBOutlet NSTextField * webTitleLabel;

@property(strong,nonatomic)IBOutlet NSTextView * logView;

@property(strong,nonatomic)ZSpider * spider;

+(ZSViewController *)mainView;

-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;


-(void)cleanLog;

@end
