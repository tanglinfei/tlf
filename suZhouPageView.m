//
// suZhouPageView.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import "suZhouPageView.h"
#import "UIImageView+WebCache.h"
@implementation suZhouPageView

@synthesize label;

-(void)setDownLabel:(UILabel*)downLabel addWeatherModel:(WeatherModel*)weatherModel
{
       for (int i=0; i<4; i++) 
    {
        UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 80, 20)];
        Label.font = [UIFont boldSystemFontOfSize:15];
        Label.textAlignment = UITextAlignmentCenter ;
        Label.backgroundColor = [UIColor clearColor];
        Label.textColor = [UIColor whiteColor];
        Label.text = [weatherModel.weekArray objectAtIndex:i+1];
        [downLabel addSubview:Label];
    }
    
    for (int i=0; i<4; i++) 
    {
        UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 35, 80, 40)];
        NSURL *url   = [NSURL URLWithString:[weatherModel.weathIconArray objectAtIndex:i+1]];
        NSLog(@"url:%@",url);
        /*NSData *data   = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];*/
        Label.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:url];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.frame=CGRectMake(25, 9, 30, 22);
        [Label addSubview:imageView];
        [downLabel addSubview:Label];
    }
    for (int i=0; i<4; i++) 
    {
        UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 80, 80, 20)];
        Label.font = [UIFont boldSystemFontOfSize:15];
        Label.textAlignment = UITextAlignmentCenter ;
        Label.backgroundColor = [UIColor clearColor];
        Label.textColor = [UIColor whiteColor];
        Label.text = [weatherModel.temperatureArray objectAtIndex:i+1];
        [downLabel addSubview:Label];
    }
    
}


-(void)setFirstPageView:(NSData*)data
{
    //全局_data
    _data = [[NSData alloc] init];
    _data = data;
    
    //初始化_weatherModel
    _weatherModel = [[WeatherModel alloc] init];
    _weatherModel.temperatureArray = [[NSMutableArray alloc] init];
    _weatherModel.weekArray     =[[NSMutableArray alloc] init];
    _weatherModel.daysArray     = [[NSMutableArray alloc] init];
    _weatherModel.weatherArray  = [[NSMutableArray alloc] init];
    _weatherModel.weathIconArray=[[NSMutableArray alloc] init];
    _weatherModel.AQIStr = [[NSString alloc] init];
    _weatherModel.AQILevel = [[NSString alloc] init];
    //添加背景图片
    _MainimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sky4"]]; 
    _MainimageView.frame = CGRectMake(0, 0, 320, 420);
    
    [self addSubview:_MainimageView];
    
    //网络请求数据
    _request = [[ASINetworkRequest alloc] init];
    NSString *str = [NSString stringWithString:@"http://115.238.28.42:8081/iserver/air?cityid=101190401"];
    [_request requestData:str andFlag:1000];
    
    _request.delegate = self;
    
    
    
    
  
}


-(void)finishTopLabels:(NSData*)data
{
  
    NSLog(@"data:%@",data);
    
    //解析数据
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataSource = [dic objectForKey:@"result"];
    
    //遍历数组dataSource取数据
    for (NSDictionary *dictionary in  dataSource)
    {   
        [_weatherModel.weekArray addObject:[dictionary objectForKey:@"week"]];
        
        [_weatherModel.weathIconArray addObject:[dictionary objectForKey:@"weather_icon"]];
        
        [_weatherModel.temperatureArray addObject:[dictionary objectForKey:@"temperature"]];
        
        [_weatherModel.daysArray addObject:[dictionary objectForKey:@"days"]];
        
        [_weatherModel.weatherArray addObject:[dictionary objectForKey:@"weather"]];
        
    }
  /*  NSLog(@"注意:_weatherModel——————————————————");
    NSLog(@"_weatherModel.weekArray:%@",_weatherModel.weekArray);
    NSLog(@"_weatherModel.weathIconArray:%@",_weatherModel.weathIconArray);
    NSLog(@"_weatherModel.temperatureArray:%@",_weatherModel.temperatureArray);
    NSLog(@"_weatherModel.daysArray:%@",_weatherModel.daysArray);
    NSLog(@"_weatherModel.weatherArray:%@",_weatherModel.weatherArray);
   */
    /**
     *添加_MainimageView上的元素
     *
     */
    NSLog(@"_weatherModel.AQIStr:%@",_weatherModel.AQIStr);
     //label1
     UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 32, 50, 50)];
     Label1.backgroundColor = [UIColor clearColor];
     //Label1.adjustsFontSizeToFitWidth = YES;
     //字体大小
     Label1.font = [UIFont boldSystemFontOfSize:30];
    NSString *str = [[NSString alloc] initWithString:_weatherModel.AQIStr ];
    Label1.text = str;
     //中心对齐 
     Label1.textAlignment = UITextAlignmentCenter;
     Label1.textColor = [UIColor blackColor];
     
     //label2
     UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 30, 30)];
     Label2.backgroundColor = [UIColor clearColor];
     //字体大小
     Label2.font = [UIFont boldSystemFontOfSize:20];
    
    NSInteger levelNumber  = [_weatherModel.AQILevel integerValue];
    
    if (levelNumber ==1) 
    {
        Label2.text = @"优";
        
    }
    else if(levelNumber==2)
    {
       Label2.text = @"良";
    }
    else if(levelNumber==3)
    {
        Label2.text = @"轻度污染";
    }else
    {
        Label2.text = @"不明确";
    }
     //中心对齐 
     Label2.textAlignment = UITextAlignmentCenter;
     Label2.textColor = [UIColor blackColor];
     //label3,下划线
     UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 150, 2)];
     Label3.backgroundColor = [UIColor redColor];
     //label4
     UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 250, 30)];
     Label4.backgroundColor = [UIColor clearColor];
     Label4.textColor = [UIColor blackColor];
     //中心对齐 
     Label4.textAlignment = UITextAlignmentCenter;
     //当天天气
     Label4.text = [NSString stringWithFormat:@"%@   %@",[_weatherModel.temperatureArray objectAtIndex:0],[_weatherModel.weatherArray objectAtIndex:0]];
     //label5
     UILabel *Label5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 320, 30)];
     Label5.backgroundColor = [UIColor clearColor];
     Label5.textColor = [UIColor blackColor];
     //中心对齐 
     Label5.textAlignment = UITextAlignmentLeft;
     Label5.text = [NSString stringWithFormat:@"%@",@"对健康不产生危害"];
     
     //label6
     UILabel *Label6 = [[UILabel alloc] initWithFrame:CGRectMake(230, 50, 90, 20)];
     Label6.backgroundColor = [UIColor clearColor];
     Label6.textColor = [UIColor whiteColor];
     Label6.textAlignment = UITextAlignmentCenter;
     Label6.font = [UIFont boldSystemFontOfSize:15];
     Label6.text = [NSString stringWithString:[_weatherModel.weekArray objectAtIndex:0]];
     //button,更新时间
     UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
     button.backgroundColor = [UIColor clearColor];
     button.frame = CGRectMake(230, 20, 90, 20);
     [button setTitle:[_weatherModel.daysArray objectAtIndex:0] forState:UIControlStateNormal];
     [button setTintColor:[UIColor redColor]];
     UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 320, 130)];
     downLabel.backgroundColor = [UIColor clearColor];
     //添加
     [_MainimageView addSubview:Label1];
     [_MainimageView addSubview:Label2];
     [_MainimageView addSubview:Label3];
     [_MainimageView addSubview:Label4];
     [_MainimageView addSubview:Label5];
     [_MainimageView addSubview:Label6];
     [_MainimageView addSubview:button];
     [_MainimageView addSubview:downLabel];
    //往下面的控件填充数据
     [self setDownLabel: downLabel addWeatherModel: _weatherModel];
     
    
}
#pragma  mark - asiNetworkRequest getDataDelegate
-(void)getData:(NSData *)data andFlag : (NSInteger)pageFlag
{
    
    NSLog(@"data:%@",data);
    
    //解析数据
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"dic:%@",dic);
    NSMutableDictionary *hbpinfoDic = [dic objectForKey:@"hbpinfo"];
    _weatherModel.AQIStr   = [[hbpinfoDic objectForKey:@"aqi"] stringValue];
    NSLog(@"AQIStr :%@",_weatherModel.AQIStr);
    _weatherModel.AQILevel = [hbpinfoDic objectForKey:@"level"];
    NSLog(@"AQILevel:%@",_weatherModel.AQILevel);
    //往上面的控件填充数据
    [self finishTopLabels:_data];
    
}



@end
