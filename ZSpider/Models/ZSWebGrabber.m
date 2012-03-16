//
//  ZSWebGrabber.m
//  ZSpider
//
//  Created by PeakJi on 12-3-13.
//  Copyright (c) 2012 Yichao Peak Ji. All rights reserved.
//

#import "ZSWebGrabber.h"

@implementation ZSWebGrabber

@synthesize connection;
@synthesize respData;

@synthesize delegate=_delegate;

#pragma mark - Actions

-(void)grabAttributesFromURL:(NSURL *)url{
    
    currentURL = [url absoluteString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    [request setHTTPMethod:@"GET"];
    
    [self cancel];
    
    self.respData=[[NSMutableData alloc] init];
    self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    [self.connection start];
}

-(void)cancel{
    
    if(self.connection!=nil)
    {
        [self.connection cancel];
        self.connection=nil;
    }
    
    [self.respData resetBytesInRange:NSMakeRange(0, respData.length)];
    self.respData=nil;
    
}

#pragma mark - NSURLConnection Delegates


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSUInteger code=[((NSHTTPURLResponse *)response) statusCode];
        
        if(code==kHTTPRequestSuccess)
        {
            
            HTTPRequestDidSuccess=YES;
            
            //Size

        }   
        else
        {
            
            
            HTTPRequestDidSuccess=NO;
            
            if(code>=kHTTPRequestFailed)
            {
                
                /*
                 switch (code) {
                 case 400:
                 ...
                 break;
                 
                 case 401:
                 ...
                 break;
                 
                 default:
                 break;
                 }
                 */
            }
        }
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.respData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if(HTTPRequestDidSuccess!=NO)
    {
        
        //URL
        dispatch_queue_t href_searching_Queue;
        href_searching_Queue = dispatch_queue_create("com.hugehard.href_searching_Queue", nil);
        dispatch_async(href_searching_Queue, ^{
            
            NSArray * hrefs= [[[TFHpple alloc] initWithHTMLData:self.respData] searchWithXPathQuery:@"//a/@href"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if([hrefs count]>0)
                {
                    
                    [[ZSViewController mainView].logView insertText:[NSString stringWithFormat:@"%@\n",currentURL]];
                    
                    for(int i=0;i<[hrefs count];i++)
                    {
                        
                        NSString * temp = [[hrefs objectAtIndex:i] content];
                        
                        if(temp!=nil&&([temp hasSuffix:@"#"]==NO)&&([temp hasPrefix:@"javascript:"]==NO))
                        {
                            
                            if([[NSURL URLWithString:temp] scheme]==nil)
                            {
                                
                                if([currentURL hasSuffix:@"/"]){
                                    currentURL=[currentURL substringToIndex:currentURL.length-1];
                                }   
                                if([temp hasPrefix:@"/"]){
                                    temp=[temp substringFromIndex:1];
                                }   
                                
                                temp = [NSString stringWithFormat:@"%@/%@",currentURL,temp];
                            }
                            
                            [[ZSURLQueue mainQueue] addURL:[NSURL URLWithString:temp]];
                        }
                    }
                    
                    [[ZSViewController mainView].logView insertText:@"-------------------------------------------------------------------------------------\n"];
                }
                
                
            });
        });
        
        
        
        
        
        //------------------
        
        
        dispatch_queue_t title_searching_Queue;
        title_searching_Queue = dispatch_queue_create("com.hugehard.title_searching_Queue", nil);
        dispatch_async(title_searching_Queue, ^{
            
            NSArray * titles= [[[TFHpple alloc] initWithHTMLData:self.respData] searchWithXPathQuery:@"//title"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if([titles count]>0&&(currentURL!=nil)&&([[titles objectAtIndex:0] content]!=nil))
                {
                    
                    [[ZSViewController mainView].webTitleLabel setStringValue:[[titles objectAtIndex:0] content]];
                    
                    [[ZSURLQueue mainQueue] addResultWithTitle:[[titles objectAtIndex:0] content] andURLString:currentURL];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:currentURL,@"url",[[titles objectAtIndex:0] content],@"title", nil];
                    
                    if(self.delegate!=nil)[self.delegate grabberDidFinish:self withAttribute:dict];
                }
                else {
                    if(self.delegate!=nil)[self.delegate grabberDidFinish:self withAttribute:nil];
                }
                
                
                
            });
        });
    }
    
    else
    {
        if(self.delegate!=nil)[self.delegate grabberDidFinish:self withAttribute:nil];
    }
    
    
}


@end
