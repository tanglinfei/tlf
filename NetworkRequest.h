//
//  NetworkRequest.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RootViewController;
@interface NetworkRequest : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData *_data;
}

-(void)requestData:(NSString *)URLString;

-(NSMutableData*)getData;
@end
