//
//  main.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @try {

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    }
    @catch (NSException *exception) { 
        
        NSLog(@"错误信息=%@",[exception  userInfo]);
    }
}
