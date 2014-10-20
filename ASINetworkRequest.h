//
//  ASINetworkRequest.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

//自定协议
@protocol  getDataDelegate<NSObject> 

-(void)getData:(NSData *)data andFlag : (NSInteger)pageFlag;
@end
@interface ASINetworkRequest : NSObject<ASIHTTPRequestDelegate>
{
    NSMutableData *_data;
    ASIHTTPRequest *_request;
    NSInteger _pageFlag;
    ASIDownloadCache *_cache;
    NSString *_cachePath;
}
-(void)requestData:(NSString *)urlString andFlag:(NSInteger)pageFlag;
@property (nonatomic,assign) id<getDataDelegate> delegate;
@end
