//
//  WeatherModel.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic,strong) NSMutableArray *weekArray;
@property (nonatomic,strong) NSMutableArray *weathIconArray;
@property (nonatomic,strong) NSMutableArray *temperatureArray;
@property (nonatomic,strong) NSMutableArray *daysArray;
@property (nonatomic,strong) NSMutableArray *weatherArray;
@property (nonatomic,strong) NSString *AQIStr;
@property (nonatomic,strong) NSString *AQILevel;


@end
