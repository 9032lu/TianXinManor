//
//  newProductListVC.m
//  logRegister
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "newProductListVC.h"

#import "MyTableViewCell.h"
#import "productVC.h"
@interface newProductListVC ()

@end

@implementation newProductListVC


- (void)viewDidLoad {
    [super viewDidLoad];

    SCREEN

    TOP_VIEW(nil)

    _array=[[NSMutableArray alloc]init];


    UIView*searchView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.2, 25, _width*0.6, 30)];
    searchView.backgroundColor=RGB(130, 232, 0);
    searchView.layer.cornerRadius=7;
    [topView addSubview:searchView];

    UIButton*searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame=CGRectMake(_width*0.83, 25, _width*0.15, 27);
    // searchButton.backgroundColor=RGB(96, 70, 35);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchButton.titleLabel.font=[UIFont systemFontOfSize:15];
    searchButton.layer.cornerRadius=5;
    [topView addSubview:searchButton];


    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, _width, _height-100) style:UITableViewStyleGrouped];
    _tabView.delegate=self;
    _tabView.dataSource=self;
    _tabView.separatorColor=[UIColor clearColor];

    [self.view addSubview:_tabView];






    _search_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.1, 6, _width*0.5, 20)];
    _search_tf.placeholder=@"请输入医师名称";
    _search_tf.delegate=self;
    _search_tf.textColor=[UIColor whiteColor];
    [_search_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_search_tf setValue:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1] forKeyPath:@"_placeholderLabel.color"];

    _search_tf.alpha=0.8;
    _search_tf.layer.cornerRadius=3;
    [searchView addSubview:_search_tf];
    UIImageView*iv2=[[UIImageView alloc]initWithFrame:CGRectMake(8, 7.5,18, 15)];
    iv2.image=[UIImage imageNamed:@"search"];
    [searchView addSubview:iv2];


    NSArray*array=[NSArray arrayWithObjects:@"预约量",@"人气",@"预约费   ", nil];
    for (int i=0; i<3; i++) {
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*_width/3, 60, _width/3, 40);
        [btn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        btn.tag=i;
        if (btn.tag==0||btn.tag==1||btn.tag==2) {
            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width/3, 5, 1, 30)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [btn addSubview:shuView];
        }
        if ([self.whoPush isEqualToString:@"salesQualityBtnClick"]||[self.whoPush isEqualToString:@"salesQualityBtnClick"]) {
            [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
            _moveView.hidden=YES;

        }
        if (btn.tag==2) {
            _xiangxia=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.25, 16.5, _width*0.05, 7)];
            _xiangxia.hidden=YES;
            _xiangxia.image=[UIImage imageNamed:@"price_high.png"];
            [btn addSubview:_xiangxia];
        }

        if (btn.tag==0) {
            [btn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            _button=btn;

        }
        btn.selected=NO;

        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }





        _moveView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.025, 99, _width/3-_width*0.05, 1)];
        _moveView.backgroundColor=APP_ClOUR;
        [self.view addSubview:_moveView];
        

    isJiazai=NO;

    _refesh=[SDRefreshHeaderView refreshView];
    __block newProductListVC*blockSelf=self;
    [_refesh addToScrollView:_tabView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData:@""];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tabView];

    __block BOOL blockIsJIazai=isJiazai;

    _refeshDown.beginRefreshingOperation=^{
        blockIsJIazai=YES;
        [blockSelf getData:@"1"];
       
    };



    [self getData:@""];


}
-(void)getData:(NSString*)more
{
    LOADVIEW
    AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];
    NSString*str=[NSString stringWithFormat:@"%@/product/search.action?" ,BASE_URL];


    NSMutableDictionary*parameter=[[NSMutableDictionary alloc]init];




    if ([_whoPush isEqualToString:@"salesQualityBtnClick"]) {
        [parameter setObject:@"1" forKey:@"type"];
    }
    if ([_whoPush isEqualToString:@"promotionBtnClick"]) {
        [parameter setObject:@"2" forKey:@"type"];
        [parameter setObject:@"1" forKey:@"isPromotion"];
    }

    if ([self.whoPush isEqualToString:@"class"]) {
        [parameter setObject:self.cagetoryId forKey:@"categoryId"];
    }
    if ([_whoPush isEqualToString:@"area"]) {
        [parameter setObject:self.cityId forKey:@"cityId"];
    }
    if ([self.whoPush isEqualToString:@"shouye"]) {
        if (self.aboutStr==nil||self.aboutStr.length==0) {
            if (isXiangying) {

            }else{

                [parameter removeAllObjects];
                [self noGoodView];
                LOADREMOVE
                return;
                
            }

        }else
        {
            [parameter setObject:self.aboutStr forKey:@"kw"];
        }


    }

    
   [parameter setObject:@"4" forKey:@"size"];

    if (isXiangying) {
        [parameter removeAllObjects];
    }

    if ([more intValue]==1) {
        static int i=0;
        i++;
         //[parameter setObject:@"1" forKey:@"tag"];
        [parameter setObject:[NSString stringWithFormat:@"%d",[@"4" intValue]*i] forKey:@"size"];

    }
    switch (_button.tag) {
        case 0:
            [parameter setObject:@"1" forKey:@"ranking"];
            break;
        case 1:
            [parameter setObject:@"2" forKey:@"ranking"];
            break;
        case 2:
            if (_button.selected) {
                [parameter setObject:@"3" forKey:@"ranking"];
            }else{
                [parameter setObject:@"4" forKey:@"ranking"];
            }

            break;
        case 3:
            [parameter setObject:@"5" forKey:@"ranking"];
            break;
        case 4:
            [parameter setObject:@"7" forKey:@"ranking"];
            break;

        default:
            break;
    }


    if (_search_tf.text.length==0) {

    }else
    {
        [parameter setObject:_search_tf.text forKey:@"kw"];

    }


    NSLog(@"%@",_search_tf.text);

    NSLog(@"%@",parameter);

    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manger POST:str parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LOADREMOVE
      //  NSLog(@"%@",responseObject);


        isJiazai=NO;


        [_refesh endRefreshing];
        [_refeshDown endRefreshing];


        NSArray*ary=[responseObject objectForKey:@"data"];

        [_array removeAllObjects];
        for (int i=0; i<ary.count; i++) {

            NSDictionary*dic2=[ary objectAtIndex:i];

            Goods*good=[[Goods alloc]init];
            good.productId=[dic2 objectForKey:@"productId"];

            good.productImage=[dic2 objectForKey:@"productImage"];
            good.productName=[dic2 objectForKey:@"productName"];
            good.ratePrice=[dic2 objectForKey:@"ratePrice"];
            good.showClicks=[dic2 objectForKey:@"showClicks"];
            good.salesQuality=[dic2 objectForKey:@"salesQuality"];
            //id distance=
            good.categoryName=[dic2 objectForKey:@"categoryName"];
            good.distance=[dic2 objectForKey:@"distance"];
            good.skuName=[dic2 objectForKey:@"productSubName"];
            [_array addObject:good];

        }

        [_tabView reloadData];

        if (_array.count==0) {
            [self noGoodView];

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----%@",error);
        LOADREMOVE

    }];

}
-(void)noGoodView
{
    UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
    tanhao.image=[UIImage imageNamed:@"tanhao"];

    [_tabView addSubview:tanhao];

    UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
    tishi.text=@"没有查到哦！";
    tishi.textColor=[UIColor grayColor];
    tishi.textAlignment=NSTextAlignmentCenter;
    tishi.font=[UIFont systemFontOfSize:14];
    [_tabView addSubview:tishi];

    tanhao.tag=7777;
    tishi.tag=77777;

}
-(void)searchBtnClick
{
    isXiangying=YES;
    [_search_tf resignFirstResponder];
    UIImageView*imagev=(UIImageView*)[_tabView viewWithTag:7777];
    UILabel*tishila=(UILabel*)[_tabView viewWithTag:77777];
    [imagev removeFromSuperview];
    [tishila removeFromSuperview];

    [self getData:@""];

}
-(void)fourBtnClick:(UIButton*)btn
{

    //isXiangying=YES;

    UIImageView*imagev=(UIImageView*)[_tabView viewWithTag:7777];
    UILabel*tishila=(UILabel*)[_tabView viewWithTag:77777];
    [imagev removeFromSuperview];
    [tishila removeFromSuperview];


    [_search_tf resignFirstResponder];

    _xiangxia.hidden=YES;

    if (btn.tag==2) {

        if (btn.selected) {
            btn.selected=NO;
            _xiangxia.image=[UIImage imageNamed:@"price_low.png"];
        }else
        {
            btn.selected=YES;
            _xiangxia.image=[UIImage imageNamed:@"price_high.png"];

        }

        _xiangxia.hidden=NO;
    }

    if (_button==btn) {


    }else
    {

        [btn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [_button setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
        _button=btn;



        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.3];

        _moveView.frame=CGRectMake(_width*0.025+_width/3*btn.tag, 99, _width/3-_width*0.05, 1);
            

        [UIView commitAnimations];

    }

    [self getData:@""];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width,1)];
    view.backgroundColor=RGB(244, 244, 244);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell) {
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //NSLog(@"%ld",(long)indexPath.row);

    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    Goods*good=[_array objectAtIndex:indexPath.row];

    [cell.imageV sd_setBackgroundImageWithURL:[NSURL URLWithString:good.productImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"doctor"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (image==nil) {
            return ;
        }

        float  imageW=image.size.width;
        float  imageH=image.size.height;
        CGRect rect;
        if (imageW>imageH) {
            rect=CGRectMake((imageW-imageH)/2, 0, imageH, imageH);

        }else
        {
            rect=CGRectMake(0, -(imageW-imageH)/2, imageW, imageW);

        }
        CGImageRef cgimage=CGImageCreateWithImageInRect([image CGImage], rect);
        [cell.imageV setBackgroundImage:[UIImage imageWithCGImage:cgimage] forState:UIControlStateNormal];
        CGImageRelease(cgimage);


    }];
    NSString*zhicheng=[NSString stringWithFormat:@"%@ %@",good.productName,good.skuName];
    NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:zhicheng];
    [atts addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:13] range:NSMakeRange(good.productName.length+1, good.skuName.length)];
    [atts addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(good.productName.length+1, good.skuName.length)];

    cell.name.attributedText=atts;
    cell.name.numberOfLines=0;
    //NSLog(@"%@",good.productName);

    NSString*price_s=[NSString stringWithFormat:@"预约费：￥%.2f",[good.ratePrice doubleValue]];
    NSMutableAttributedString*atts2=[[NSMutableAttributedString alloc]initWithString:price_s];
    [atts2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:14] range:NSMakeRange(0, 4)];
    [atts2 addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 4)];
    cell.price.attributedText=atts2;

    cell.comment.text=[NSString stringWithFormat:@"人气 （%@）",good.showClicks];

    cell.salesQuality.text=[NSString stringWithFormat:@"预约量（%@）",good.salesQuality];



    NSString*shanchang=[NSString stringWithFormat:@"擅长：%@",good.categoryName];
    NSMutableAttributedString*atts1=[[NSMutableAttributedString alloc]initWithString:shanchang];
    [atts1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:14] range:NSMakeRange(0, 3)];
    [atts1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    cell.shanchang.attributedText=atts1;

    id distance=good.distance;



    if (distance==[NSNull null]) {
        cell.distance.hidden=YES;
        cell.loca_IV.hidden=YES;
    }else
    {
        NSString*locaStr=[NSString stringWithFormat:@"约%@km",good.distance];
        cell.loca_IV.frame=CGRectMake(_width*0.55+(_width*0.4-locaStr.length*9-10),  _width*0.175+25+(_width*0.075-15)/2,13, 15);
        cell.distance.text=[NSString stringWithFormat:@"约%@km",good.distance];
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30+_width*0.25;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"faewukl");

     Goods*good=[_array objectAtIndex:indexPath.row];
    PUSH(productVC)
    vc.productId=good.productId;

}
-(void)backClick
{
    if ([self.whoPush isEqualToString:@"shouye"]||[self.whoPush isEqualToString:@"class"]) {
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.tabBar.hidden=YES;
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.tabBar.hidden=YES;
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
