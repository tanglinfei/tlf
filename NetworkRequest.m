//
//  NetworkRequest.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NetworkRequest.h"
@implementation NetworkRequest
-(NSData*)getData
{
    return _data;
}

-(void)requestData:(NSString *)URLString
{
    //初始化_data
    _data = [[NSMutableData alloc] init ];
    //对URLString进行编码转化
    NSString *str=[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:URL];
    //设置缓存策略(只有在cache中不存在data时才从原始地址下载)
   // [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    //请求超时时间60s
   // [request setTimeoutInterval:60];
    //请求数据
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
}


#pragma mark- NSURLConnectionDataDelegate
//开始接受数据调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{  
    
    [_data  appendData: data];
    
}


//完成接受数据
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //发送数据请求完成通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishLoading1" object:nil];
  
}



@end
