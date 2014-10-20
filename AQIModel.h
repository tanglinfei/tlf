//
//  AQIModel.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>
@interface AQIModel : NSObject
@property  (nonatomic,strong) NSMutableArray *addressArray;//监测地址
@property  (nonatomic,strong) NSMutableArray *AQIArray;//AQI值
@property  (nonatomic,strong) NSMutableArray *levelArray;//AQI等级
@property  (nonatomic,strong) NSMutableArray *addrIdArray;//监测地址标识
@end
