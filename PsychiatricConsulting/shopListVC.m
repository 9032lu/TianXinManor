//
//  shopListVC.m
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "shopListVC.h"
#import "define.h"
#import "myShopCell.h"

#import "productVC.h"
#import "hospitalVC.h"
@interface shopListVC ()

@end

@implementation shopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN;
    self.navigationController.navigationBar.hidden=YES;

    TOP_VIEW(@"商家专区");
//    backTi.hidden=YES;
//    backBtn.hidden=YES;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    [self.view addSubview:_scrollView];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
   // _tableView.rowHeight=140+_width*0.25;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];



    _refesh=[SDRefreshHeaderView refreshView];
    __block shopListVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getdata:@""];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getdata:@"more"];
        
        
    };

    _shopArray=[[NSMutableArray alloc]init];

   

}
-(void)getdata:(NSString*)more
{

    UIImageView*imagev=(UIImageView*)[_tableView viewWithTag:7777];
    UILabel*tishila=(UILabel*)[_tableView viewWithTag:77777];
    [imagev removeFromSuperview];
    [tishila removeFromSuperview];
    LOADVIEW
    NSString*url;
    if ([more isEqualToString:@""]) {
        url=ASK_SHOP_LIST_URL;
    }else
    {
        url=[NSString stringWithFormat:@"%@&tag=2&id=%d",ASK_SHOP_LIST_URL,_currentId];
    }

    NSLog(@"%@",url);
      [requestData getData:url complete:^(NSDictionary *dic) {
        LOADREMOVE
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        NSLog(@"hhhhhh%@",dic);

          NSMutableArray*baseArray=[dic objectForKey:@"data"];

          if ([more isEqualToString:@""]) {


            _shopArray=[NSMutableArray arrayWithArray:(NSArray*)[dic objectForKey:@"data"]];

          }else
          {
              for (int i=0; i<baseArray.count; i++) {
                  [_shopArray addObject:[baseArray objectAtIndex:i]];
              }

          }
          _currentId=[[[_shopArray lastObject] objectForKey:@"shopId"] intValue];

        //_shopArray=[dic objectForKey:@"data"];

        [_tableView reloadData];
        if (_shopArray.count==0||_shopArray==nil) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];
            tanhao.tag=7777;

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有商铺入驻哦";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];
            tishi.tag=77777;
        }
    }];






}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_shopArray objectAtIndex:indexPath.row];

    id  goodArray=[dic objectForKey:@"goods"];
    if (goodArray==[NSNull null]) {
        goodArray=@[];
    }else
    {

    }
    NSArray*array=goodArray;
    if (array.count==0) {
        return 75;
    }else
    {
        return 140+_width*0.25;
    }


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myShopCell*cell=[[myShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    NSDictionary*dic=[_shopArray objectAtIndex:indexPath.row];
    id  shopLogo=[dic objectForKey:@"shopLogo"];
    if (shopLogo==[NSNull null]) {
        shopLogo=nil;
    }

    [cell.imageV sd_setBackgroundImageWithURL:[NSURL URLWithString:shopLogo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"fang"]];

    //[cell.imageV addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    cell.name.text=[dic objectForKey:@"shopName"];

    cell.shopBtn.tag=[[dic objectForKey:@"shopId"] intValue];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //cell.shopBtn.backgroundColor=[UIColor redColor];

   [cell.shopBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];


    id distance=[dic objectForKey:@"distance"];
    if (distance==[NSNull null]) {
        cell.locaIV.hidden=YES;
       // cell.loca_distance.text=[NSString stringWithFormat:@">>100km"];
    }else
    {
        cell.loca_distance.text=[NSString stringWithFormat:@"约%.2fkm",[[dic objectForKey:@"distance"] doubleValue]];

//        UILabel*_loca_distance_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.8, 25,_width*0.2, 15)];
//        _loca_distance_L.text=@"约";
//        _loca_distance_L.textColor=APP_ClOUR;
//        _loca_distance_L.textAlignment=NSTextAlignmentCenter;
//        _loca_distance_L.font=[UIFont systemFontOfSize:12];
//        [cell.contentView addSubview:_loca_distance_L];
    }
   // cell.loca_distance.hidden=YES;

    id  goodArray=[dic objectForKey:@"goods"];
    if (goodArray==[NSNull null]||goodArray==nil) {
      //  goodArray=@[];
    }else
    {
        NSArray*goodArray=[dic objectForKey:@"goods"];
        for (int i=0; i<goodArray.count; i++) {
            NSDictionary*gooddic=[goodArray objectAtIndex:i];


//
//            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(_width*0.0475+_width*0.3175*i-1, 85-1, _width*0.27+2, _width*0.25+2)];
//            view.layer.borderColor=RGB(220, 220, 220).CGColor;
//            view.layer.borderWidth=1;
//            [cell.contentView addSubview:view];

            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(_width*0.0625+_width*0.3125*i, 85, _width*0.25, _width*0.25);
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[gooddic objectForKey:@"productImage"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"doctor"]];
            button.tag=[[gooddic objectForKey:@"productId"] intValue];
            [button addTarget:self action:@selector(shopProductBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            button.clipsToBounds=YES;
            button.layer.cornerRadius=5;

            [cell.contentView addSubview:button];

            UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.0475+_width*0.3175*i, 85+_width*0.25, _width*0.27,25)];
            name.text=[gooddic objectForKey:@"productName"];
            name.textAlignment=NSTextAlignmentCenter;
            name.textColor=[UIColor blackColor];
            name.font=[UIFont systemFontOfSize:16];
            [cell.contentView addSubview:name];

            UILabel*price_l=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.0475+_width*0.3175*i, 85+_width*0.25+25, _width*0.27,20)];
           // price_l.text=[NSString stringWithFormat:@"预约费￥%.2f",[[gooddic objectForKey:@"ratePrice"] doubleValue]];
            price_l.textAlignment=NSTextAlignmentLeft;
            price_l.textColor=[UIColor redColor];

            NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",[[gooddic objectForKey:@"ratePrice"] doubleValue]]];
            [atts addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:14] range:NSMakeRange(0, 0)];
            [atts addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 0)];
            price_l.attributedText=atts;

            price_l.font=[UIFont systemFontOfSize:12];
            [cell.contentView addSubview:price_l];
        }
        [cell addSubview:cell.contentView];
    }
    UIButton*shop=[UIButton buttonWithType:UIButtonTypeCustom];
    shop.frame=CGRectMake(0, 15, _width,50);
    shop.backgroundColor=[UIColor clearColor];
    [shop addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    shop.tag=[[dic objectForKey:@"shopId"] intValue];
    [cell.contentView addSubview:shop];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)shopProductBtnClick:(UIButton*)btn
{
    NSLog(@"jhhhhh");

    productVC*vc=[[productVC alloc]init];
    vc.productId=[NSString stringWithFormat:@"%ld",(long)btn.tag];
    [self.navigationController pushViewController:vc animated:YES];


}
-(void)click:(UIButton*)button
{
    NSLog(@"----------%ld",(long)button.tag);
    hospitalVC*vc=[[hospitalVC alloc]init];
    vc.shopId=[NSString stringWithFormat:@"%ld",(long)button.tag];
    [self.navigationController pushViewController:vc animated:YES];
    

}
-(void)backClick
{
    POP
   
//    [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.tabBar.hidden=NO;

}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    [super viewWillAppear:animated];

    count=0;
    [self getdata:@""];
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
