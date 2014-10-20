
//  RootViewController.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.

#import "RootViewController.h"
#define PAGENUM 4

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
     
        self.title = @"苏州环保";
       
    }
    return self;
}


#pragma mark- add _rootScrollView and _pageController
-(void)addRootScrollViewAndPageControl
{
    //初始化_rootScrollView
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 418)];
    _rootScrollView.contentSize = CGSizeMake(320*PAGENUM, 418);
    //支持翻页
    _rootScrollView.pagingEnabled  = YES;

    
    //初始化PageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 460-44-20, 320, 20)];
    //设定总页数
    _pageControl.numberOfPages = PAGENUM;    
    //设定当前页
    _pageControl.currentPage  = 0;
    //背景颜色
    _pageControl.backgroundColor = [UIColor clearColor];
    
    //添加_rootScrollView和_pageControl到self.view
    [self.view addSubview:_rootScrollView];
    [self.view addSubview:_pageControl];

    //代理
    _rootScrollView.delegate = self;
 
}
#pragma mark - addMenu
-(void)addMenu
{
    UIView *helpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    helpView.backgroundColor = [UIColor whiteColor];
    //标识导航栏左边按钮的点击次数
    tag = 0;
    /*self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];*/
    
    //设置菜单按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom]; 
    UIImage *backBtnImage = [UIImage imageNamed:@"naviMenu"] ; 
    [_backBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor colorWithRed:0 green:0.7 blue:0.2 alpha:1] forState:UIControlStateNormal];
    _backBtn.alpha = 0.2;
    [_backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal]; 
    [_backBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside]; 
    _backBtn.frame = CGRectMake(0, 0, 40, 30); 
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:_backBtn] ; 
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    
    
    
    
    
    
    
    
    
    
    //菜单视图
    _menuView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    _menuView.contentSize = CGSizeMake(320, 530);
    _menuView.backgroundColor = [UIColor whiteColor];
    /*
     **菜单选项
     *
     */
    /*****首页*****/
    UIImageView *imgView1  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu1"]];
    imgView1.tag=0;
    imgView1.userInteractionEnabled =YES;
    imgView1.frame = CGRectMake(5, 20, 122, 117);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 137, 122, 30)];
    label1.text = @"首页";
    label1.textAlignment = UITextAlignmentCenter;
    //手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeOffset:)];
    [imgView1 addGestureRecognizer:singleTap];
    
    /***消息公开*****/
    
    UIImageView *imgView2  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu2"]];
    imgView2.tag = 1;
    imgView2.userInteractionEnabled =YES;
    imgView2.frame = CGRectMake(150, 20, 122, 117);
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(145, 138, 122, 30)];
    label2.text = @"消息公开";
    label2.textAlignment = UITextAlignmentCenter;
    //手势
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeOffset:)];
    [imgView2 addGestureRecognizer:singleTap2];
   
     /***环保新闻*****/
    UIImageView *imgView3  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu3"]];
    imgView3.tag = 2;
    imgView3.userInteractionEnabled =YES;
    imgView3.frame = CGRectMake(5, 180, 122, 117);
    UILabel *label3= [[UILabel alloc] initWithFrame:CGRectMake(0, 298, 122, 30)];
    label3.text = @"环保新闻";
    label3.textAlignment = UITextAlignmentCenter;
    //手势
    UITapGestureRecognizer *singleTap3= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeOffset:)];
    [imgView3 addGestureRecognizer:singleTap3];
    /***环保知识*****/
    UIImageView *imgView4  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu4"]];
    imgView4.tag = 3;
    imgView4.userInteractionEnabled =YES;
    imgView4.frame = CGRectMake(150, 180, 122, 117);
    UILabel *label4= [[UILabel alloc] initWithFrame:CGRectMake(145, 298, 122, 30)];
    label4.text = @"环保知识";
    label4.textAlignment = UITextAlignmentCenter;
    //手势
    UITapGestureRecognizer *singleTap4= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeOffset:)];
    [imgView4 addGestureRecognizer:singleTap4];
    /***我的*****/
  /*  UIImageView *imgView5  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu5"]];
    imgView5.tag = 4;
    imgView5.userInteractionEnabled =YES;
    imgView5.frame = CGRectMake(5, 333, 122, 117);
    UILabel *label5= [[UILabel alloc] initWithFrame:CGRectMake(0, 451, 122, 30)];
    label5.text = @"我的";
    label5.textAlignment = UITextAlignmentCenter;
    //手势
    UITapGestureRecognizer *singleTap5= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeOffset:)];
    [imgView5 addGestureRecognizer:singleTap5];*/
    
    [_menuView addSubview:label1];
    [_menuView addSubview:imgView1];
    [_menuView addSubview:label2];
    [_menuView addSubview:imgView2];
    [_menuView addSubview:label3];
    [_menuView addSubview:imgView3];
    [_menuView addSubview:label4];
    [_menuView addSubview:imgView4];
    /*[_menuView addSubview:label5];
    [_menuView addSubview:imgView5];*/
    //添加导航视图
    [self.view addSubview:_menuView];
    //添加视图helpView，用于掩盖_menuView
    [self.view addSubview:helpView];

    
}
#pragma mark- menuChangeRootscrollViewOffset
-(void)changeOffset:(UITapGestureRecognizer*)tap
{ 
    int i = tap.view.tag;
     CGPoint point;
    switch (i)
    {
        case 0:
            point.x=0;
            point.y = 0;
            break;
        case 1:
            point.x=320*i;
            point.y = 0;
            break; 
        case 2:
            point.x=320*i;
            point.y = 0;
            break; 
        case 3:
            point.x=320*i;
            point.y = 0;
            break;
        case 4:
            point.x=320*i;
            point.y = 0;
            break;
        default:
            break;
    }
    
     
    [_rootScrollView setContentOffset:point animated:YES];
    flag = point.x/320;
    
    //数据加载提示设置
    if (flag==0) 
    {
        _promptView.hidden = YES;
    }
    else
    {
        _promptView.hidden = NO;
    }
      
    //分别请求网络
    switch (flag) {
        case 0:_pageControl.currentPage =flag;
           _tittle = @"苏州环保";
              _urlString = [NSString stringWithString:@"http://api.k780.com:88/?app=weather.future&weaid=401&appkey=11631&sign=cfa5d088646788e4d08fc36013bd9d94&format=json"];
          [_asiNetworkRequest0 requestData:_urlString andFlag:flag];
                        break;
        case 1:  _pageControl.currentPage =flag;
            _tittle = @"信息公开";
              _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver/air?cityid=101190401"];
              [_asiNetworkRequest1 requestData:_urlString andFlag:flag];
            break;
        case 2:_pageControl.currentPage =flag;
            _tittle = @"环保新闻";
              _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=10"];
              [_asiNetworkRequest2 requestData:_urlString andFlag:flag];
            break;
            
        case 3:_pageControl.currentPage =flag;
               _tittle = @"环保知识";
              _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=2&num=10&referid=0"];
              [_asiNetworkRequest3 requestData:_urlString andFlag:flag];
               break;
        default:
            break;
    }
    //延迟1秒
   //[NSThread sleepForTimeInterval:1];
    [self showMenu];
      
}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    KIOS7;//频幕适配
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
    _promptView.hidden = YES;
    
    //初始化
    _asiNetworkRequest0 = [[ASINetworkRequest alloc] init];
    _asiNetworkRequest1 = [[ASINetworkRequest alloc] init];
    _asiNetworkRequest2 = [[ASINetworkRequest alloc] init];
    _asiNetworkRequest3 = [[ASINetworkRequest alloc] init];

    //设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0 green:0.5 blue:0.2 alpha:1], UITextAttributeTextColor,nil]];
                                                                    
   
    //设置导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white"] forBarMetrics: UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor]; 
    //添加菜单项
    [self addMenu];
    //添加_rootScrollView和_pageControl
    [self addRootScrollViewAndPageControl];
    
    //添加数据请求提示
    [self.view addSubview:_promptView];
    
    
   
       
    //-----------------------------设置suZhouPage（第一页）
    _firstPageView = [[suZhouPageView alloc] initWithFrame:CGRectMake(320*0, 0, 320, 418)];
    _firstPageView.image = [UIImage imageNamed:@"sky4"];
    _firstPageView.backgroundColor = [UIColor clearColor];
    _urlString = [NSString stringWithString:@"http://api.k780.com:88/?app=weather.future&weaid=401&appkey=11631&sign=cfa5d088646788e4d08fc36013bd9d94&format=json"];
    flag = 0;
    [_asiNetworkRequest0 requestData:_urlString andFlag:flag];
    
    [_rootScrollView addSubview: _firstPageView];
    //-----------------------------设置PublicInformationView(第二页)
    _publicInformationView = [[PublicInformationView alloc] init];
    _publicInformationView.frame = CGRectMake(320*1, 0, 320, 418);
    //_publicInformationView.image = [UIImage imageNamed:@"public"];
    _publicInformationView.delegate = self;
    [_rootScrollView addSubview:_publicInformationView];
    
    //--------------------------------设置EnvironmentInformationView(第三页)
    _envInfView = [[EnvironmentInformationView alloc] init];
    _envInfView.frame = CGRectMake(320*2, 0, 320, 418);
    _envInfView.delegate=self;
    _envInfView.userInteractionEnabled = YES;
    _envInfView.backgroundColor = [UIColor clearColor];
    [_rootScrollView addSubview:_envInfView];
    
    //-----------------------------设置EviKnowledgeView（第四页）
   _eviKnowledgeView           = [[EviKnowledgeView alloc] init];
   _eviKnowledgeView.frame     = CGRectMake(320*3, 0, 320, 418);
    _eviKnowledgeView.delegate = self;
    _eviKnowledgeView.backgroundColor = [UIColor clearColor];
    [_rootScrollView addSubview:_eviKnowledgeView];
    
   
    //网络请求代理
    _asiNetworkRequest0.delegate = self;
    _asiNetworkRequest1.delegate = self;
    _asiNetworkRequest2.delegate = self;
    _asiNetworkRequest3.delegate = self;

}
#pragma mark - showMenu
-(void)showMenu
{  //点击次数标识
    tag++;
    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^() {
        [self.view  exchangeSubviewAtIndex:0 withSubviewAtIndex:2];
        if (tag%2==0) 
        {   
            [_backBtn setTitle:@"菜单" forState:UIControlStateNormal];
            //反转之后显示相应的tittle
            self.title = _tittle;
            //[self.navigationItem.leftBarButtonItem setTitle:@"菜单"]; 
        }else
        {  
            [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
            self.title = @"导航";
            //[self.navigationItem.leftBarButtonItem setTitle:@"返回"];
        }
        
    } completion:nil];
    
    
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    flag = _rootScrollView.contentOffset.x/320;
    //提示设置
    if (flag==0) 
    {
        _promptView.hidden = YES;
    }
    else
    {
        _promptView.hidden = NO;
    }
    switch (flag)
    {
            
        case 0:_pageControl.currentPage =flag;
            self.title =_tittle= @"苏州";
    _urlString = [NSString stringWithString:@"http://api.k780.com:88/?app=weather.future&weaid=401&appkey=11631&sign=cfa5d088646788e4d08fc36013bd9d94&format=json"];
            [_asiNetworkRequest0 requestData:_urlString andFlag:flag];
            break;
       
        case 1:  _pageControl.currentPage =flag;
            self.title =_tittle= @"信息公开";
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver/air?cityid=101190401"];
            [_asiNetworkRequest1 requestData:_urlString andFlag:flag];
            break;
            
        case 2:_pageControl.currentPage =flag;
            self.title = _tittle=@"环保新闻";
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=0&num=10&referid=10"];
            [_asiNetworkRequest2 requestData:_urlString andFlag:flag];
            break;
            
        case 3:_pageControl.currentPage =flag;
            self.title =_tittle= @"环保知识";
            _urlString = [NSString stringWithString:@"http://115.238.28.42:8081/iserver//getnewslist.action?type=0&newstype=2&num=10&referid=0"];
            [_asiNetworkRequest3 requestData:_urlString andFlag:flag];
            break;
            
        case 4:_pageControl.currentPage =flag;
            self.title = _tittle=@"环保日志";
            break;
        default:
            break;
    }
}

#pragma mark - GoToOtherControllerDelegate
-(void) gotoController:(NSURL *)url
{  
     //初始化webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    _webController = [[UIViewController alloc] init ];
    [_webController.view addSubview:webView];
    
    
    //设置返回按钮
    _webBackBtn= [UIButton buttonWithType:UIButtonTypeCustom]; 
    UIImage *backBtnImage = [UIImage imageNamed:@"naviMenu"] ; 
    [_webBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_webBackBtn setTitleColor:[UIColor colorWithRed:0 green:0.7 blue:0.2 alpha:1] forState:UIControlStateNormal];
    _webBackBtn.alpha = 0.2;
    [_webBackBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal]; 
    [_webBackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside]; 
    _webBackBtn.frame = CGRectMake(0, 0, 40, 30); 
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:_webBackBtn] ; 
    _webController.navigationItem.leftBarButtonItem = backButton;
    
    webView.delegate = self;
    
    //初始化_indicatorView(风火轮)
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //设置_indicatorView的风格
    [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    //使_indicatorView位于_webController的中心
    [_indicatorView setCenter:_webController.view.center];
    [_webController.view addSubview:_indicatorView];
   
    [self.navigationController pushViewController:_webController animated:YES];
}

#pragma mark - back to rootViewController
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
   
}


#pragma mark - PublicViewToOtherControllerDelegate
-(void)publicViewToController:(NSString *)urlStr
{
    PublicDetailViewController *pvc = [[PublicDetailViewController alloc] init];
    pvc.urlStr = urlStr;
    [self.navigationController pushViewController:pvc animated:YES];
}
#pragma mark - ASINetworkRequest delegate
-(void)getData:(NSData *)data andFlag:(NSInteger)pageFlag
{
    _promptView.hidden = YES;
    switch (pageFlag) 
    {
        case 0:
             [_firstPageView setFirstPageView : data];
            break;
        case 1:  [_publicInformationView setPublicInformationView :data];
            break;
        case 2:  [_envInfView setEnvironmentInformationView:data];   
            break;
        case 3:[_eviKnowledgeView setEviKnowledgeView:data];
            break;
        default:
            break;
    }
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_indicatorView startAnimating];
    _indicatorView.hidden = NO;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_indicatorView stopAnimating];
    _indicatorView.hidden = YES;
    
}
@end
