//
//  PublicDetailModel.h
//  LoveEnvironmennt
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicDetailModel : NSObject
@property (nonatomic,strong) NSMutableArray *nameArr;//监测因子名称
@property (nonatomic,strong) NSMutableArray *concetrationArr;//监测因子浓度
@property (nonatomic,strong) NSMutableArray *levelArr;//达标情况
@property (nonatomic,strong) NSString *AddresStr;//其他的字符串，里面包含地址
@end


