//
//  ZSViewController.m
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import "ZSViewController.h"

#import "ZSpider.h"

@interface ZSViewController ()

@end

@implementation ZSViewController

@synthesize urlField;
@synthesize startButton;
@synthesize stopButton;
@synthesize logView;
@synthesize webTitleLabel;

@synthesize spider;


static ZSViewController * _mainView = nil; 

+(ZSViewController *)mainView{
    @synchronized([ZSViewController class])  
	{  
		if (!_mainView)  
			_mainView=[[self alloc] initWithNibName:@"ZSViewController" bundle:nil]; 
		return _mainView;  
	}  
	return nil;  
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _mainView=self;
    }
    
    return self;
}



-(IBAction)start:(id)sender{
    
    [self.logView setString:@"Started Log...\n"];
    
    if(self.spider==nil)
    {
        self.spider=[[ZSpider alloc] init];
    }
    NSString * url = self.urlField.stringValue;
    
    if([url hasSuffix:@"/"]){
        url=[url substringToIndex:url.length-1];
    }        
    
    [self.startButton setEnabled:NO];
    [self.stopButton setEnabled:YES];
    
    [self.spider putToURL:[NSURL URLWithString:url]];
}

-(IBAction)stop:(id)sender{
    
    if(self.spider)[self.spider kill];
    [[ZSURLQueue mainQueue].queue removeAllObjects];
    
    [self.startButton setEnabled:YES];
    [self.stopButton setEnabled:NO];
    
    [self.logView insertText:@"-------------------------------------------------------------------------------------\nStopped.\n"];
}




@end
