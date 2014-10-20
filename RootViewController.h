//
//  RootViewController.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>
#import "suZhouPageView.h"
#import "PublicInformationView.h"
#import "EnvironmentInformationView.h"
#import "EviKnowledgeView.h"
#import "PublicDetailViewController.h"
#import "ASINetworkRequest.h"
@interface RootViewController : UIViewController<UIScrollViewDelegate,GoToOtherControllerDelegate,PublicViewToOtherControllerDelegate,UIWebViewDelegate,getDataDelegate>
{
    UIScrollView *_rootScrollView;     //各个页面的容器
    UIPageControl *_pageControl;
    NSInteger flag;   //标识在第几个页面
    UIViewController *_webController;
    UIActivityIndicatorView *_indicatorView;
    NSString *_urlString;
    suZhouPageView *_firstPageView ;
    PublicInformationView *_publicInformationView;
    EnvironmentInformationView *_envInfView;
    EviKnowledgeView *_eviKnowledgeView;
    ASINetworkRequest *_asiNetworkRequest0;
    ASINetworkRequest *_asiNetworkRequest1;
    ASINetworkRequest *_asiNetworkRequest2;
    ASINetworkRequest *_asiNetworkRequest3;
    UIScrollView *_menuView ;
    NSInteger tag;
    NSString *_tittle;
    UIButton *_backBtn;
    UIButton *_webBackBtn;
    UIView   *_promptView;//提示数据加载
    
}
-(void)showMenu;
@end
