//
//  EnvironmentInformationView.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import "EnvironmentInformationView.h"
#import "UIImageView+WebCache.h"
#define PAGENUMBER  4
@implementation EnvironmentInformationView
@synthesize delegate=_delegate;

#pragma mark - addTopButtonsAndLabels
-(void)addTopButtonsAndLabels
{
    //用于标识button1，button2的点击事件
    _clickCount = 0;
    //---------button1
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label1.text = @"实时新闻";
    label1.font = [UIFont boldSystemFontOfSize:15];
    UIButton *button1 = [UIButton buttonWithType:   UIButtonTypeRoundedRect ];
    button1.frame = CGRectMake(80, 10, 60, 30);
    
    //---------button2
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label2.text = @"环保事件";
    label2.font = [UIFont boldSystemFontOfSize:15];
    UIButton *button2 = [UIButton buttonWithType:   UIButtonTypeRoundedRect  ];
    button2.backgroundColor = [UIColor clearColor];

    button2.frame = CGRectMake(160, 10, 60, 30);
   
    
    //--------------移动线条label3
    if (_label3)
    {
        [_label3 removeFromSuperview];
         _label3 = Nil;
    }
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 80, 5)];
    _label3.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.3 alpha:1];
    
    //-------------------下划线label4
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, 200, 2)];
    label4.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.3 alpha:1];
    
    //点击触发事件
    [button1 addTarget:self action:@selector(clickAnimation1) forControlEvents:UIControlEventTouchUpInside ];
    [button2 addTarget:self action:@selector(clickAnimation2) forControlEvents:UIControlEventTouchUpInside];
    
    //--------------------添加
    [button1 addSubview:label1];
    [button2 addSubview:label2];
    [_mainimageView addSubview:button1];
    [_mainimageView addSubview:button2];
    [_mainimageView addSubview:_label3];
    [_mainimageView addSubview:label4];
}
#pragma mark - clickTopButton
-(void)clickAnimation1
{
    _pageFlag = 6;
    //动画
    [UIView animateWithDuration:0.5 animations:^(void) {
        _label3.frame = CGRectMake(70, 40, 80, 5);
    } ];
    //-------------------请求网络
    _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=10"];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
    
}

-(void)clickAnimation2
{
    _pageFlag = 7;
    //动画
    [UIView animateWithDuration:0.5 animations:^(void) {
        _label3.frame = CGRectMake(150, 40, 80, 5);
    } ];
    
    //-------------------请求网络
    _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=1&num=10&referid=0"];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
    
}

#pragma mark - addTableView
-(void)addTableView
{
    //-------------------------tableView
    _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(10, 48, 300, 420-45) style: UITableViewStylePlain];
    _tableView.contentSize = CGSizeMake(300, 500) ;
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
        //添加图片
        NSDictionary *dictionary = [_picturesArray objectAtIndex: i];
        
        NSString *imageString = [NSString stringWithString:[dictionary objectForKey:@"imgurl"] ];
        NSString *string = [imageString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *imageUrl = [NSURL URLWithString:string]; 
       
        //NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        //UIImage *image = [UIImage imageWithData:data];
        UIImageView *imgeView = [[UIImageView alloc] init];
        [imgeView setImageWithURL:imageUrl placeholderImage:nil]; 
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
    NSDictionary *dictionary = [_picturesArray objectAtIndex: button.tag];
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
    _envInfoViewModel.picturesArray = [hbpinfoDictionary objectForKey:@"pictures"];
    _envInfoViewModel.newsArray     = [hbpinfoDictionary objectForKey:@"news"];
    _picturesArray  = _envInfoViewModel.picturesArray;
    
    /**
     *区分“实时新闻”和“环保事件”的数据
     */
    if (_pageFlag==6) 
    {
        _newsArray =  _envInfoViewModel.newsArray ;
        _pageFlag = 100;
    }
    if (_pageFlag==7) 
    {
        _newsArray =  _envInfoViewModel.newsArray ;
        _pageFlag = 101;
    }
    //拼接
    _newsArray      = [_newsArray arrayByAddingObjectsFromArray:_envInfoViewModel.newsArray ];
    NSLog(@"_picturesArray:%@",_picturesArray);
    
}

#pragma mark - setEnvironmentInformationView
-(void)setEnvironmentInformationView:(NSMutableData*)data
{   
    
    //上拉刷新计数
    _refreshFootCount = 10;
    
    //_newsArray和 _picturesArray用于初始化各控件数据
    _newsArray     = [NSMutableArray array];
    
    _picturesArray = [NSMutableArray array];
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
    _tableView.dataSource   = self;
    _tableView.delegate     = self;
    _tableView.pullDelegate = self;
    
   //初始化_NetworkRequst,用于请求网络数据
    _networkRequst = [[ASINetworkRequest alloc] init];
    _networkRequst.delegate = (id)self;
   
}

#pragma mark - ASINetworkRequest delegate
-(void)getData:(NSData *)data andFlag : (NSInteger)pageFlag
{   
    //取消加载数据状态
    _tableView.pullTableIsRefreshing = NO;
    _tableView.pullTableIsLoadingMore = NO;
    //对_envInfoViewModel赋值
    [self initEnvInfoViewModel:data];
    
    //刷新_tableView
    [_tableView reloadData];
}
#pragma mark - TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_newsArray count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"myCell";
    EviInfViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==Nil)
    {
        cell = [[EviInfViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    NSDictionary *dic    = [_newsArray objectAtIndex:indexPath.row];
    
    //添加图片
    NSString *picString  = [dic objectForKey:@"picurl" ];
    NSString *string     = [picString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *picUrl        = [NSURL URLWithString:string];
     /*NSData *data         = [NSData dataWithContentsOfURL:picUrl];
    UIImage *image       = [UIImage imageWithData:data];
    cell.pictureView.image     = image;
    */
    [cell.pictureView setImageWithURL:picUrl placeholderImage:nil];
    //标题
    cell.titleLabel.text   = [dic objectForKey:@"title"];
    cell.contentLabel.text = [dic objectForKey:@"content"];
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    return cell;
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic    = [_newsArray objectAtIndex:indexPath.row];
    NSString *urlString = [dic objectForKey:@"pageurl"];
    NSURL *url = [NSURL URLWithString:urlString];
    [self.delegate gotoController:url];
}
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{ 
    _tableView.pullLastRefreshDate = [NSDate date];
    
    //-------------------请求网络
    _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=10"];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    //上拉刷新计数
    _refreshFootCount += 10;
    NSLog(@"_refreshFootCount:%i",_refreshFootCount);
    //-------------------请求网络
   /* switch (_refreshFootCount)
    {
        case 20:
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=20"];
            break;
        case 30:
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=30"];
            break;
        case 40:
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=40"];
            break;
        case 50:
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=50"];
            break;
        case 60:
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=60"];
            break;
          
        default:
            break;
    }*/
    _urlString = [NSString stringWithFormat:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=%i",_refreshFootCount ];
    [_networkRequst requestData:_urlString andFlag:_pageFlag];
}

@end
