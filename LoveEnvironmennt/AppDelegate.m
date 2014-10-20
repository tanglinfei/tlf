//
//  AppDelegate.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ASIDownloadCache.h"
#import "PublicDetailViewController.h"
@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RootViewController *rvc =[[RootViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:rvc];
    self.window.rootViewController = nvc;
    
    //缓存文字（图片不缓存）
    [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
   /* PublicDetailViewController *pvc = [[PublicDetailViewController alloc] init];
    self.window.rootViewController  = pvc;*/
   
    return YES;
}


@end
