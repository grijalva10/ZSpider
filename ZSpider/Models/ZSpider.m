//
//  ZSpider.m
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import "ZSpider.h"

@implementation ZSpider

@synthesize results;
@synthesize grabber;

-(id)init{
    self = [super init];
    
    if(self)
    {
        waitUntilDone=NO;
        logDisplay=nil;
        progress=0;
    }
    
    return self;
}

-(void)putToURL:(NSURL *)url{
    if(self.grabber==nil)
    {
        self.grabber=[[ZSWebGrabber alloc] init];
        self.grabber.delegate=self;
        progress=0;
    }
    waitUntilDone=YES;
    [[ZSURLQueue mainQueue] addURL:url];
    [self.grabber grabAttributesFromURL:url];
}

-(void)setLogDisplay:(id)sender{
    logDisplay = sender;
}

-(void)kill{
    if(self.grabber!=nil)
    {
        [grabber cancel];
    }
    waitUntilDone=NO;
    progress=0;
}

#pragma mark - Grabber Delegate

-(void)grabberDidFinish:(ZSWebGrabber *)grabber withAttribute:(NSDictionary *)attributes{
    waitUntilDone=NO;
    progress++;
    if(progress<[[ZSURLQueue mainQueue].queue count])
    {
        [self.grabber grabAttributesFromURL:[[ZSURLQueue mainQueue].queue objectAtIndex:progress]];
    }
    else
    {
        //Done Queue!
        [[ZSViewController mainView].logView insertText:@"Done."];
    }
}

@end
