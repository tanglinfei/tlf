//
//  EviKnowledge.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EviInfViewCell.h"
#import "EnvInfoViewModel.h"//重用环保新闻的2个类
#import "ASINetworkRequest.h"
#import "ToOtherViewControllerPro.h"
@interface EviKnowledgeView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView  *_mainimageView;
    UILabel *_label3;
    UITableView *_tableView;
    UIScrollView *_scrollView;
    NSInteger _timeCount;
    NSMutableArray *_picturesArray;
    NSMutableArray *_newsArray ;
    NSInteger _clickCount;
    ASINetworkRequest *_networkRequst;
    EnvInfoViewModel *_envInfoViewModel;
    NSString *_urlString;
    NSInteger _pageFlag;//标识第几个页面
    
}
@property (nonatomic,assign) id<GoToOtherControllerDelegate> delegate;
-(void)setEviKnowledgeView:(NSData*)data;
-(void)addHeaderScrollViewButton;

@end
