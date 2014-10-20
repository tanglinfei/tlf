//
//  EnvironmentInformationView.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>
#import "PullTableView.h"
#import "EviInfViewCell.h"
#import "EnvInfoViewModel.h"
#import "ASINetworkRequest.h"
#import "ToOtherViewControllerPro.h"

@interface EnvironmentInformationView : UIImageView<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>
{
    UIImageView  *_mainimageView;
    UILabel *_label3;
    PullTableView *_tableView;
    UIScrollView *_scrollView;
    NSInteger _timeCount;
    NSArray *_picturesArray;
    NSArray *_newsArray ;
    NSInteger _clickCount;
    ASINetworkRequest *_networkRequst;
    EnvInfoViewModel *_envInfoViewModel;
    NSString *_urlString;
    NSInteger _pageFlag;//标识第几个页面
    NSInteger _refreshFootCount;//上拉刷新计数
}
@property(nonatomic,assign) id<GoToOtherControllerDelegate> delegate;
-(void)setEnvironmentInformationView:(NSData*)data;
-(void)addHeaderScrollViewButton;
@end
