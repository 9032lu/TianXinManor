//
//  newsVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "newsVC.h"
#import "webViewVC.h"
#import "transformTime.h"
@interface newsVC ()

@end

@implementation newsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"新闻中心")
    self.navigationController.navigationBar.hidden=YES;



    UIView*upView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.15, 64, _width*0.7, 40)];
//    upView.layer.borderWidth=1;
//    upView.layer.borderColor=[UIColor grayColor].CGColor;
    [self.view addSubview:upView];


    for (int i=0; i<2; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.35*i, 0, _width*0.35, 40);
        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        if (i==0) {
             [button setTitle:@"企业新闻" forState:UIControlStateNormal];
            _lastBtn=button;
            button.tag=11;

        }else
        {
             [button setTitle:@"行业新闻" forState:UIControlStateNormal];
             [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.tag=12;

        }
        button.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [button addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [upView addSubview:button];


    }
    UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.35, 5, 1, 30)];
    shuxian.backgroundColor=RGB(234, 234, 234);
    [upView addSubview:shuxian];






    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, _width, _height-64-40) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    [self.view addSubview:_tableView];

    _refesh=[SDRefreshHeaderView refreshView];
    __block newsVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{

//        NSLog(@"======%d",_lastBtn.tag);
        if (_lastBtn.tag ==11) {
            [blockSelf getData:@"" andtypeId:@"11"];

        }else{
            [blockSelf getData:@"" andtypeId:@"12"];

        }

    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{


        if (_lastBtn.tag ==11) {
            [blockSelf getData:@"more" andtypeId:@"11"];

        }else{
            [blockSelf getData:@"more" andtypeId:@"12"];

        }
    };

    [self getData:@"" andtypeId:[NSString stringWithFormat:@"%ld",(long)_lastBtn.tag]];

}
-(void)getData:(NSString*)more andtypeId:(NSString*)typeId
{
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    NSString*url;



    url=NEWS_LIST_URL(typeId);
    LOADVIEW
    if ([more isEqualToString:@"more"]) {
        url=[NSString stringWithFormat:@"%@&tag=2",url];
    }
      //NSLog(@"%@",url);
    [requestData getData:url complete:^(NSDictionary *dic) {
       NSLog(@"**************%@",url);
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        LOADREMOVE
        id dd=[dic objectForKey:@"data"];
        if (dd==[NSNull null]) {
            dd=@[];
        }
        _dataArray=dd;
        NSLog(@"**************%@",_dataArray);

        [_tableView reloadData];
        NSArray*nullA=@[];
        if (_dataArray.count==0||_dataArray==nullA||_dataArray==nil) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-160)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-160)/2+60, _width, 20)];
            tishi.text=@"暂无相关新闻";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
        }
    }];
   // NSLog(@"%@",ADV_LIST_URL(@"1"));
//    [requestData getData:ADV_LIST_URL(@"1") complete:^(NSDictionary *dic) {
//       // NSLog(@"%@",dic);
//        _advistArray=[dic objectForKey:@"data"];
//        [_tableView reloadData];
//    }];

}
-(void)selectBtnClick:(UIButton*)button
{
    if (button==_lastBtn) {

    }else
    {
        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [_lastBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    _lastBtn=button;

    [self getData:@"" andtypeId:[NSString stringWithFormat:@"%ld",(long)button.tag]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _width*0.24+20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return _width/3;
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _smallScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, 170)];
    _smallScrollV.contentSize=CGSizeMake(_width*_advistArray.count, _width/3);
    _smallScrollV.pagingEnabled=YES;
    _smallScrollV.bounces=NO;
    //_smallScrollV.backgroundColor=[UIColor redColor];
    //NSLog(@"jjjjjjj%d",_advistArray.count);


    if (_advistArray.count==0) {
        UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/3)];
        imagev.image=[UIImage imageNamed:@"chang"];
        [_smallScrollV addSubview:imagev];
    }else{
        for (int i=0; i<_advistArray.count; i++) {
            //NSLog(@"hhhhhh");
            UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
            [view sd_setBackgroundImageWithURL:[NSURL URLWithString:[[_advistArray objectAtIndex:i] objectForKey:@"advImage"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];
            view.frame=CGRectMake(_width*i, 0, _width, _width/3);

            view.tag=i;
            view.backgroundColor=[UIColor darkGrayColor];
            if (i==2) {
                view.backgroundColor=[UIColor redColor];
            }
            [view addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
            //view.backgroundColor=[UIColor yellowColor];
            [_smallScrollV addSubview:view];
        }

    }
    _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, _width/3-30, _width, 30)];
    _pc.currentPage=0;
    _pc.numberOfPages=_advistArray.count;
    if (_advistArray.count==1) {
        _pc.currentPageIndicatorTintColor=[UIColor clearColor];
    }
    _pc.currentPageIndicatorTintColor=[UIColor whiteColor];
    [_smallScrollV addSubview:_pc];

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*proDic=[_dataArray objectAtIndex:indexPath.row];
    NSString*newsId=[proDic objectForKey:@"newsId"];
    PUSH(webViewVC)
    vc.url=NEWS_DETAIL_URL(newsId);
    vc.whoPush=@"hh";
    self.tabBarController.tabBar.hidden=YES;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    NSDictionary*proDic=[_dataArray objectAtIndex:indexPath.row];
    id newsImageUrl=[proDic objectForKey:@"newsImageUrl"];
    NSString*newsTitle=[proDic objectForKey:@"newsTitle"];
    NSString*depict=[proDic objectForKey:@"depict"];

//    id depict=[proDic objectForKey:@"depict"];
//    if (depict==[NSNull null]) {
//        depict=@"";
//    }
//    NSLog(@"====%@",depict);
    NSString* pubDate=[proDic objectForKey:@"pubDate"];

    if (newsImageUrl==[NSNull null]) {
        newsImageUrl=nil;
    }



    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 10, _width*0.27, _width*0.24)];
    [imageview sd_setImageWithURL:[NSURL URLWithString:newsImageUrl] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    imageview.layer.cornerRadius=2;
    imageview.clipsToBounds=YES;
    [cell.contentView addSubview:imageview];

    UILabel*name_L=[[UILabel alloc]init];
    name_L.text=newsTitle;
    name_L.numberOfLines=1;
    name_L.textAlignment=NSTextAlignmentLeft;
    name_L.textColor=[UIColor darkGrayColor];
    name_L.font=[UIFont boldSystemFontOfSize:15];
    CGSize sizen =[self boundWithSize:CGSizeMake(MAXFLOAT, 0) WithString:name_L.text WithFont:[UIFont boldSystemFontOfSize:15]];
    name_L.frame=CGRectMake(_width*0.32, 10, _width*0.66, sizen.height);
    [cell.contentView addSubview:name_L];



    UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.32, sizen.height+13, _width*0.66, _width*0.1)];
    price_L.text=[NSString stringWithFormat:@"\t%@",[self filterHTML:[NSString stringWithFormat:@"%@",depict]]];
    price_L.numberOfLines=2;
    price_L.textAlignment=NSTextAlignmentLeft;
    price_L.textColor=[UIColor grayColor];
    price_L.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:price_L];

    if (newsImageUrl==nil) {
        imageview.hidden=YES;
        name_L.frame=CGRectMake(_width*0.02, 10, _width*0.94, sizen.height);
//        price_L.frame =CGRectMake(_width*0.02, 5+_width*0.12, _width*0.94, _width*1);

    }


    UILabel*shop_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.32, _width*0.18+10, _width*0.63, _width*0.06)];
     shop_L.text=[transformTime prettyDateWithReference:pubDate];
    NSLog(@"************%@",pubDate);

//    shop_L.text=[pubDate substringToIndex:10];
    shop_L.numberOfLines=1;
    shop_L.textAlignment=NSTextAlignmentRight;
    shop_L.textColor=[UIColor grayColor];
    shop_L.font=[UIFont systemFontOfSize:12];
    [cell.contentView addSubview:shop_L];



//    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(_width*0.85, 15+_width*0.18, _width*0.15, 15+_width*0.06);
//    [button setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [button setImageEdgeInsets:UIEdgeInsetsMake((15+_width*0.06-15)/2, (_width*0.15-15)/2, (15+_width*0.06-15)/2,  (_width*0.15-15)/2)];
//
//    [button addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [cell.contentView addSubview:button];

    return cell;
}
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];

        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];


    }
//        NSString * regEx = @"<([^>]*)>";
//        html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
-(void)shareBtnClick
{
    NSLog(@"分享");
}
-(void)advistBtn:(UIButton*)button
{
    NSLog(@"广告位");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)backClick
{
    POP
    self.tabBarController.tabBar.hidden=YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGSize)boundWithSize:(CGSize)size  WithString:(NSString*)str  WithFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};

    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return retSize;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
