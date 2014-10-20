//
//  PublicInformationView.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-21.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "PublicInformationView.h"
@implementation PublicInformationView
@synthesize delegate = _delegate;

-(void)setTopImageView
{
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.text = @"监测点";
    lable1.textAlignment =  UITextAlignmentRight;
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(111, 0, 109, 44)];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.text = @"AQI";
    lable2.textAlignment =  UITextAlignmentRight;
    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(221, 0, 100, 44)];
    lable3.backgroundColor = [UIColor clearColor];
    lable3.text = @"等级";
    lable3.textAlignment =  UITextAlignmentCenter;
            
    [_TopimageView addSubview:lable1];
    [_TopimageView addSubview:lable2];
    [_TopimageView addSubview:lable3];
    
    
}

-(void)setPublicInformationView:(NSData*)data
{
   //设置该视图的交互性
    self.userInteractionEnabled = YES;
    
    //初始化AQIModel
    _AQIModel = [[AQIModel alloc] init];
    _AQIModel.addressArray = [[NSMutableArray alloc] init];
    _AQIModel.AQIArray     = [[NSMutableArray alloc] init];
    _AQIModel.levelArray   = [[NSMutableArray alloc] init];
    _AQIModel.addrIdArray  = [[NSMutableArray alloc] init];
        
    _TopimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //设置_TopimageView的背景颜色
    _TopimageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_TopimageView];
    //设置上面的试图
    [self setTopImageView];
    [self giveData:data];
    
}
#pragma mark - finishLoadData
-(void)giveData:(NSData*)data
{
   
    
    //数据解析
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary *hbpinfoDictionary = [dictionary objectForKey:@"hbpinfo"];
    NSMutableArray *pm25Array = [hbpinfoDictionary objectForKey:@"pm25"];
    
    //遍历数组pm25Array取address和AQI
    for (NSMutableDictionary *dic in pm25Array) 
    {   //取地址
        [_AQIModel.addressArray addObject: [dic objectForKey:@"address"]];
        //取AQI值
         NSMutableDictionary *dic1 = [dic objectForKey:@"china"];
        [_AQIModel.AQIArray addObject:[dic1 objectForKey:@"realvalue"]];
        //AQI的level
        [_AQIModel.levelArray addObject:[dic objectForKey:@"level"]];
        //监测地址标识
        [_AQIModel.addrIdArray addObject:[dic objectForKey:@"id"]];
        
    }
    
    
    //添加tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 416-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_tableView];
    //代理
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    
}

#pragma mark - tableView datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    
    //NSLog(@"_AQIModel.addressArray:%@",_AQIModel.addressArray);
     return [_AQIModel.addressArray count];
       
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义静态标识
    static NSString *identify = @"myCell";
    AQICell *cell = [tableView  dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) 
    {
        cell = [[AQICell alloc] initWithStyle:  UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.addressLabel.text = [_AQIModel.addressArray objectAtIndex:indexPath.row];
    //NSLog(@"_AQIModel.levelArray:%@",_AQIModel.levelArray);
    //取出来的数据类型是NSNumber,要进行转化
    cell.AQILabel.text    =  [[_AQIModel.AQIArray objectAtIndex:indexPath.row] stringValue];
    
   NSInteger levelNumber  = [[_AQIModel.levelArray objectAtIndex:indexPath.row] integerValue] ;
    //设置单元格的点击效果
    cell.selectionStyle   =  UITableViewCellSelectionStyleNone;
    
    if (levelNumber ==1) 
    {
        cell.levelLabel.text = @"一级 优";
        
    }
    else if(levelNumber==2)
    {
         cell.levelLabel.text = @"二级 良";
    }
    else
    {
        cell.levelLabel.text = @"三级 轻度污染";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *addId  = [_AQIModel.addrIdArray objectAtIndex:indexPath.row];
    NSString *urlStr = [NSString stringWithFormat:@"http://115.238.28.42:8081/iserver/siteair?cityid=101190401&siteid=%@&type=1",addId];
    [self.delegate publicViewToController:urlStr];
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
















@end
