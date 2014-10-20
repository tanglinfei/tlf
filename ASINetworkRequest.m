//
//  ASINetworkRequest.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ASINetworkRequest.h"

@implementation ASINetworkRequest
@synthesize delegate = _delegate;

-(void)requestData:(NSString *)urlString andFlag:(NSInteger)pageFlag
{
   // NSLog(@"urlstring:%@",urlString);
    //NSLog(@"pageFlage:%i",pageFlag);
    _pageFlag = pageFlag;
    NSString *string = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    _request = [ASIHTTPRequest requestWithURL:url];
    [_request setTimeOutSeconds:60];
    [_request setDelegate:self];
    [_request startAsynchronous];
    
    
}
#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //get data from network
    NSData *responseData = [request responseData];
    //NSLog(@"responseData:%@",responseData);
    //数据回调
    [self.delegate getData:responseData andFlag:_pageFlag];
    
    
    
}

@end
