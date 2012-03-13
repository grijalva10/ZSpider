//
//  ZSWebGrabber.h
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"

#import "ZSViewController.h"

#import "ZSURLQueue.h"
@class ZSURLQueue;

@class ZSWebGrabber;

#define kHTTPRequestSuccess 200
#define kHTTPRequestFailed  400

@protocol grabberDelegate<NSObject>
-(void)grabberDidFinish:(ZSWebGrabber *)grabber withAttribute:(NSDictionary *)attributes;
@end

@interface ZSWebGrabber : NSObject<NSURLConnectionDelegate>{
    BOOL HTTPRequestDidSuccess;
    NSString * currentURL;
}

@property(nonatomic,strong)NSURLConnection * connection;
@property(nonatomic,strong)NSMutableData * respData;

@property (assign, nonatomic)id <grabberDelegate>delegate;

-(void)grabAttributesFromURL:(NSURL *)url;
-(void)cancel;

@end
