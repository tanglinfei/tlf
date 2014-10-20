//
//  suZhouPage.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkRequest.h"
#import "WeatherModel.h"

@interface suZhouPageView : UIImageView<getDataDelegate>
{
    WeatherModel *_weatherModel;
    UIImageView *_MainimageView;
    ASINetworkRequest *_request;
    NSData *_data;
 }
@property (nonatomic,strong) UILabel *label;

-(void)setFirstPageView:(NSData*)data;
-(void)finishTopLabels:(NSData*)data;

@end
