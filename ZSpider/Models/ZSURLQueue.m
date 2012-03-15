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
@synthesize result;

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
            _mainQueue.result=[[NSMutableArray alloc] init];
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
        self.result=nil;
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

-(void)addResultWithTitle:(NSString *)title andURLString:(NSString *)urlString{
    if(title!=nil&&urlString!=nil)
    {
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:title,@"title",urlString,@"url", nil];
        
        [self.result addObject:dict];
    }
}

-(NSString *)getCSVString{
    NSMutableString * res =[[NSMutableString alloc] initWithString:@""];
    
    for(int i=0;i<[self.result count];i++)
    {
        NSString * title = [[result objectAtIndex:i] objectForKey:@"title"];
        
        title=[title stringByReplacingOccurrencesOfString:@"," withString:@" "];
        
        [res appendFormat:@"%@,",title];
        [res appendFormat:@"%@\n",[[result objectAtIndex:i] objectForKey:@"url"]];
    }
    
    return [NSString stringWithString:res];

}



@end
