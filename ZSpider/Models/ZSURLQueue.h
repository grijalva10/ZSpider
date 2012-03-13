//
//  ZSURLQueue.h
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZSViewController.h"

@class ZSURLQueue;

@interface ZSURLQueue : NSObject


@property(nonatomic,strong)NSMutableArray * queue;

+(ZSURLQueue *)mainQueue;

-(void)addURL:(NSURL *)url;
-(BOOL)isNewURL:(NSURL *)url;

@end
