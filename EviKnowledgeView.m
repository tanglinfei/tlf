//
//  EviKnowledge.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "EviKnowledgeView.h"
#import "UIImageView+WebCache.h"
#define PAGENUMBER  4
@implementation EviKnowledgeView
@synthesize delegate=_delegate;

#pragma mark - addTopButtonsAndLabels
-(void)addTopButtonsAndLabels
{
    //用于标识button1，button2的点击事件
    _clickCount = 0;
    //---------button1
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label1.text = @"概念介绍";
    label1.font = [UIFont boldSystemFontOfSize:15];
    UIButton *button1 = [UIButton buttonWithType:   UIButtonTypeRoundedRect ];
    button1.frame = CGRectMake(60, 10, 60, 30);
    
    //---------button2
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label2.text = @"低碳生活";
    label2.font = [UIFont boldSystemFontOfSize:15];
    UIButton *button2 = [UIButton buttonWithType:   UIButtonTypeRoundedRect  ];
    button2.frame = CGRectMake(140, 10, 60, 30);
    
    //---------button3
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label3.text = @"危化知识";
    label3.font = [UIFont boldSystemFontOfSize:15];
    UIButton *button3 = [UIButton buttonWithType:   UIButtonTypeRoundedRect  ];
    button3.frame = CGRectMake(220, 10, 60, 30);
    
    
    
    //--------------移动线条label3
    if (_label3) 
    {
        [_label3 removeFromSuperview];
         _label3 = Nil;
    }
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 80, 5)];
    _label3.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.3 alpha:1];
    
    //-------------------下划线label4
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(40, 45, 250, 2)];
    label4.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.3 alpha:1];
    
    //点击触发事件
    [button1 addTarget:self action:@selector(clickAnimation1) forControlEvents:UIControlEventTouchUpInside ];
    [button2 addTarget:self action:@selector(clickAnimation2) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(clickAnimation3) forControlEvents:UIControlEventTouchUpInside];
    
    //--------------------添加
    [button1 addSubview:label1];
    [button2 addSubview:label2];
    [button3 addSubview:label3];
    [_mainimageView addSubview:button1];
    [_mainimageView addSubview:button2];
    [_mainimageView addSubview:button3];
    [_mainimageView addSubview:_label3];
    [_mainimageView addSubview:label4];
}
#pragma mark - clickTopButton
-(void)clickAnimation1
{
    _pageFlag = 8;
    [UIView animateWithDuration:0.5 animations:^(void) {
        _label3.frame = CGRectMake(50, 40, 80, 5);
    } ];
    //-------------------请求网络
    _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=2&num=10&referid=0"];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
    
}

-(void)clickAnimation2
{
    _pageFlag = 9;
    [UIView animateWithDuration:0.5 animations:^(void) {
        _label3.frame = CGRectMake(130, 40, 80, 5);
    } ];
    
    //-------------------请求网络
    _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=3&num=10&referid=0"];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
    
}
-(void)clickAnimation3
{
    _pageFlag = 10;

    [UIView animateWithDuration:0.5 animations:^(void) {
        _label3.frame = CGRectMake(210, 40, 80, 5);
    } ];
    
    //-------------------请求网络
    _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=4&num=10&referid=0"];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
    
}

#pragma mark - addTableView
-(void)addTableView
{
    //-------------------------tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 48, 300, 420-45) style: UITableViewStylePlain];
    _tableView.rowHeight = 90;
    
    /*
     *初始化表视图的头部视图
     */
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 137)];
    headView.backgroundColor = [UIColor redColor];
    
    //添加scrollView到tableHeaderView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 137)];
    _scrollView.contentSize = CGSizeMake(300*PAGENUMBER, 137);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    //支持翻页
    _scrollView.pagingEnabled  = YES;
    [headView addSubview:_scrollView];
    //使tableHeaderView上scrollView定时滚动
    _timeCount = 0; 
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollTimer)  userInfo:nil repeats:YES];
    
    //添加
    _tableView.tableHeaderView = headView;
    [_mainimageView addSubview:_tableView];
    [self addHeaderScrollViewButton];
    
}
#pragma mark -tableViewScrollButton
-(void)addHeaderScrollViewButton
{
    for (int i =0; i<4; i++) 
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(300*i, 0, 300, 137);
        //button.backgroundColor = [UIColor redColor];
        //添加图片
        NSDictionary *dictionary = [_envInfoViewModel.picturesArray objectAtIndex: i];
        
        NSString *imageString = [NSString stringWithString:[dictionary objectForKey:@"imgurl"] ];
        NSString *string = [imageString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *imageUrl = [NSURL URLWithString:string];
        /*NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *image = [UIImage imageWithData:data];*/
        UIImageView *imgeView = [[UIImageView alloc] init];
        [imgeView setImageWithURL:imageUrl placeholderImage:Nil];
        imgeView.frame = CGRectMake(0, 0, 300, 137);
        button.tag = i;
        [button addSubview:imgeView];
        [button addTarget:self action:@selector(clickScrollButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview: button];
    }
}
#pragma mark - clickTableHeaderViewScrollButtonAction
-(void)clickScrollButtonAction:(UIButton *)button
{
    //get information's url
    NSDictionary *dictionary = [_envInfoViewModel.picturesArray objectAtIndex: button.tag];
    NSString *urlString = [dictionary objectForKey:@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    [self.delegate gotoController:url];
    
}

#pragma mark - scrollTimer 
-(void)scrollTimer
{
    
    if (_timeCount < PAGENUMBER-1) 
    {
        _timeCount++;
        [_scrollView scrollRectToVisible:CGRectMake(300*_timeCount, 0, 300, 137) animated:YES];
        
    }
    else
    {
        _timeCount=0;
        [_scrollView scrollRectToVisible:CGRectMake(300*_timeCount, 0, 300, 137) animated:YES];
        
        
    }
    
    
}

#pragma mark - initEnvInfoViewModel
-(void)initEnvInfoViewModel:(NSData*)data
{
    /******处理传递过来的数据******/
    
    //初始化_envInfoViewModel
    _envInfoViewModel = [[EnvInfoViewModel alloc] init];
    _envInfoViewModel.picturesArray = [[NSMutableArray alloc] init];
    _envInfoViewModel.newsArray     = [[NSMutableArray alloc] init];
    NSMutableDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *hbpinfoDictionary = [jsonDictionary objectForKey:@"hbpinfo"];
    _envInfoViewModel.picturesArray= [hbpinfoDictionary objectForKey:@"pictures"];
    _envInfoViewModel.newsArray   = [hbpinfoDictionary objectForKey:@"news"];
}

#pragma mark - setEviKnowledgeView
-(void)setEviKnowledgeView:(NSData*)data
{   
    //初始化_envInfoViewModel
    [self initEnvInfoViewModel:data];
    
    //--------------mainimageView,作为其他控件的容器
    _mainimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    _mainimageView.backgroundColor = [UIColor clearColor];
    //注意：使mainimageView能与它上面的控件能够交互，默认是不可以的 
    _mainimageView.userInteractionEnabled = YES;
    
    //--------------------添加子控件
    [self addSubview:_mainimageView];
    [self addTopButtonsAndLabels];
    [self addTableView];
    //tableView代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //初始化_NetworkRequst,用于请求网络数据
    _networkRequst = [[ASINetworkRequest alloc] init];
    _networkRequst.delegate = (id)self;
    
}





#pragma mark - ASINetworkRequest delegate
-(void)getData:(NSMutableData *)data andFlag : (NSInteger)pageFlag
{   
    [self initEnvInfoViewModel:data];
    [_tableView reloadData];
}
#pragma mark - TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"count=%@",_newsArray.count);
    return [_envInfoViewModel.newsArray count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"myCell";
    EviInfViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==Nil)
    {
        cell = [[EviInfViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    NSDictionary *dic    = [_envInfoViewModel.newsArray objectAtIndex:indexPath.row];
    
    //添加图片
    NSString *picString  = [dic objectForKey:@"picurl" ];
    NSString *string     = [picString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *picUrl        = [NSURL URLWithString:string];
   /* NSData *data         = [NSData dataWithContentsOfURL:picUrl];
    UIImage *image       = [UIImage imageWithData:data];*/
    [cell.pictureView setImageWithURL:picUrl];
    
    //标题
    cell.titleLabel.text   = [dic objectForKey:@"title"];
    cell.contentLabel.text = [dic objectForKey:@"content"];
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get information's url
    NSDictionary *dic    = [_envInfoViewModel.newsArray objectAtIndex:indexPath.row];
    NSString *urlString = [dic objectForKey:@"pageurl"];
    NSURL *url = [NSURL URLWithString:urlString];
    [self.delegate gotoController:url];
}
@end
