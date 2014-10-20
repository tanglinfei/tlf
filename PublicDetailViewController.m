//
//  PublicDetailViewController.m
//  LoveEnvironmennt
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "PublicDetailViewController.h"

@implementation PublicDetailViewController
@synthesize urlStr = _urlStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
       /* self.navigationController.navigationBar.userInteractionEnabled =YES;
       UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
       
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(back)];
        barItem.customView = customView;
    
        self.navigationItem.leftBarButtonItem = barItem;*/
      
        
       /* self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back2"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];*/
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom]; 
        UIImage *backBtnImage = [UIImage imageNamed:@"back"] ; 
        backBtn.alpha = 0.2;
        [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal]; 
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside]; 
        backBtn.frame = CGRectMake(0, 0, 40, 30); 
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ; 
        self.navigationItem.leftBarButtonItem = backButton;
        
        
     
    }
    return self;
}

#pragma mark -
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - setTopImageView
-(void)setTopImageView
{
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.text = @"监测检测因子";
    lable1.textAlignment =  UITextAlignmentRight;
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(111, 0, 109, 44)];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.text = @"浓度";
    lable2.textAlignment =  UITextAlignmentRight;
    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(221, 0, 100, 44)];
    lable3.backgroundColor = [UIColor clearColor];
    lable3.text = @"达标情况";
    lable3.textAlignment =  UITextAlignmentCenter;
    
    [_TopimageView addSubview:lable1];
    [_TopimageView addSubview:lable2];
    [_TopimageView addSubview:lable3];
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    KIOS7;//频幕适配，宏定义
    //数据加载提示视图
    _promptView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 150, 40)];
    //提示语
    UILabel *promptLabel= [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 120, 30)];
    promptLabel.text = @"数据加载中..";
    promptLabel.textColor = [UIColor greenColor];
    promptLabel.adjustsFontSizeToFitWidth = YES;
    [_promptView addSubview:promptLabel];
    //初始化indicatorView(风火轮)
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    //设置indicatorView的风格
    [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_promptView addSubview:indicatorView];
    [indicatorView startAnimating];
    //使_promptView位于_webController的中心
    [_promptView setCenter:self.view.center];
    _promptView.hidden = NO;
    //添加提示视图
    [self.view addSubview:_promptView];
    
    
     
    //初始化
    _publicDetailModel= [[PublicDetailModel alloc] init];
    _publicDetailModel.nameArr   = [[NSMutableArray alloc] init];
    _publicDetailModel.concetrationArr = [[NSMutableArray alloc] init];
    _publicDetailModel.levelArr  = [[NSMutableArray alloc] init];
    _publicDetailModel.AddresStr = [[NSString alloc] init];
    
    
    //----添加_TopimageView
    _TopimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //设置_TopimageView的背景颜色
    _TopimageView.backgroundColor = [UIColor colorWithRed:0.0 green:0.9 blue:0.3 alpha:1];
    [self.view addSubview:_TopimageView];
    //设置上面的试图
    [self setTopImageView];
    //----初始化网络请求对象
    _request = [[ASINetworkRequest alloc] init];
    _request.delegate = self;
    [_request requestData:self.urlStr andFlag:0];
   
}

#pragma mark - getDataDelegate

-(void)getData:(NSData *)data andFlag : (NSInteger)pageFlag
{
    //数据加载提示
    _promptView.hidden = YES;
  
    //数据解析
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary *hbpinfoDictionary = [dictionary objectForKey:@"hbpinfo"];
   
    //存地址
    _publicDetailModel.AddresStr = [hbpinfoDictionary objectForKey:@"address"];
    self.title = [NSString stringWithFormat:@"%@ 详情",_publicDetailModel.AddresStr];
    //遍历hbpinfoDictionary取出所要用到的数据
    for (id obj in hbpinfoDictionary.allValues) 
    {
       
        if ([obj  isKindOfClass:[NSDictionary class] ]) 
        {
            [_publicDetailModel.nameArr addObject:[obj objectForKey:@"name"]];
            NSString *str = [obj objectForKey:@"nd"];
            NSArray *arr  = [str componentsSeparatedByString:@";"];
            
            [_publicDetailModel.concetrationArr addObject:[arr objectAtIndex:0]];
            [_publicDetailModel.levelArr addObject:[arr objectAtIndex:1]];
        }
        
    }
    
    
    //添加tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 416-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    //代理
    _tableView.dataSource = self;
    _tableView.delegate   = (id)self;
}

#pragma mark -UITableView datasource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_publicDetailModel.concetrationArr count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    
    AQIDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==Nil) 
    {
        cell = [[AQIDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.nameLabel.text = [_publicDetailModel.nameArr objectAtIndex:indexPath.row];
    cell.concentrationLabel.text = [_publicDetailModel.concetrationArr objectAtIndex:indexPath.row];
    cell.levelLabel.text = [_publicDetailModel.levelArr objectAtIndex:indexPath.row];
    return cell;
}





@end
