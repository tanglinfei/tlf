//
//  PublicDetailViewController.h
//  LoveEnvironmennt
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkRequest.h"
#import "PublicDetailModel.h"
#import "AQIDetailCell.h"
@interface PublicDetailViewController : UIViewController<getDataDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_TopimageView;//视图上面的标签
    ASINetworkRequest *_request;
    PublicDetailModel *_publicDetailModel;
    UIView *_promptView ;//加载数据提示
}
@property (nonatomic,strong) NSString *urlStr;
@end
