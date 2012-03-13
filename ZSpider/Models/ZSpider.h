//
//  ZSpider.h
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZSWebGrabber.h"


#import "ZSURLQueue.h"

@class ZSWebGrabber;
@class ZSURLQueue;

@interface ZSpider : NSObject<grabberDelegate>{
    BOOL waitUntilDone;
    id logDisplay;
    int progress;
}

@property(nonatomic,strong) NSMutableString * results;

@property(nonatomic,strong)ZSWebGrabber * grabber;

-(id)init;
-(void)putToURL:(NSURL *)url;
-(void)setLogDisplay:(id)sender;
-(void)kill;

@end
