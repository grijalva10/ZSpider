//
//  ZSURLQueue.m
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import "ZSURLQueue.h"

@implementation ZSURLQueue


@synthesize queue;

#pragma mark - Init

static ZSURLQueue * _mainQueue = nil; 

+(ZSURLQueue *)mainQueue{
    @synchronized([ZSURLQueue class])  
	{  
		if (!_mainQueue)  
			_mainQueue=[[self alloc] init]; 
        if(_mainQueue.queue==nil)
        {
            _mainQueue.queue=[[NSMutableArray alloc] init];
        }
		return _mainQueue;  
	}  
	return nil;  
}


+(id)alloc  
{  
	@synchronized([ZSURLQueue class])  
	{  
		NSAssert(_mainQueue == nil, @"Attempted to allocate a second instance of a singleton.");  
		_mainQueue = [super alloc];  
		return _mainQueue;  
	}  
	return nil;  
}  


- (id)init
{
    self = [super init];
    if (self) {
        self.queue=nil;
    }
    return self;
}

#pragma mark - Actions

-(void)addURL:(NSURL *)url{
    if(url!=nil&&[self isNewURL:url])
    {
        [self.queue addObject:[url copy]];
        [[ZSViewController mainView].logView insertText:[NSString stringWithFormat:@"  └%@\n",[url absoluteString]]];
    }
}
-(BOOL)isNewURL:(NSURL *)url{
    for(NSURL * oldURL in self.queue)
    {
        if ([[oldURL absoluteString] isEqualToString:[url absoluteString]])
        {
            return NO;
        }
    }
    return YES;
}

@end
