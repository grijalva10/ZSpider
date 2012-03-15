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
    
    [self performSelector:@selector(cleanLog) withObject:nil afterDelay:30.0f];
}

-(IBAction)stop:(id)sender{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cleanLog) object:nil];
    
    if(self.spider)[self.spider kill];
    
    
    [self.startButton setEnabled:YES];
    [self.stopButton setEnabled:NO];
    
    [self.logView insertText:@"-------------------------------------------------------------------------------------\nStopped.\n"];
    
    
    NSSavePanel * savePanel =[NSSavePanel savePanel];
    
    [savePanel setRequiredFileType:@"csv"];
    
    [savePanel setTitle:@"SaveAsPlainText"];
    
    if([savePanel runModal] == NSOKButton){
        
        [[[ZSURLQueue mainQueue] getCSVString] writeToURL:[savePanel URL] atomically:YES encoding:NSUTF8StringEncoding error:nil];   
        
    }
    
    [[ZSURLQueue mainQueue].queue removeAllObjects];
    [[ZSURLQueue mainQueue].result removeAllObjects];
}


-(void)cleanLog{
    [self.logView setString:@"===================\nClean Log...\n===================\n"];
    [self performSelector:@selector(cleanLog) withObject:nil afterDelay:30.0f];
}


@end
