//
//  PublicInformationView.h
//  LoveEnvironmennt
//  Created by  on 14-9-21.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>
#import "AQIModel.h"
#import "AQICell.h"
@protocol  PublicViewToOtherControllerDelegate <NSObject>
-(void)publicViewToController:(NSString*)urlStr;
@end
@interface PublicInformationView : UIImageView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_TopimageView;
    AQIModel *_AQIModel;
}
@property (nonatomic,retain) id<PublicViewToOtherControllerDelegate> delegate;
-(void)setPublicInformationView:(NSData*)data;
-(void)giveData:(NSData*)data;
@end
