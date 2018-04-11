//
//  productCollectVC.m
//  logRegister
//
//  Created by apple on 15-1-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "productCollectVC.h"

#import "productVC.h"
#import "hospitalVC.h"
@interface productCollectVC ()

@end

@implementation productCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
   SCREEN
    TOP_VIEW(@"我的关注")

    _array=[[NSMutableArray alloc]initWithCapacity:0];




    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _tabView.delegate=self;
    _tabView.dataSource=self;
    _tabView.separatorColor=[UIColor clearColor];

    [self.view addSubview:_tabView];
    self.view.backgroundColor=RGB(234, 234, 234);

    _refesh=[SDRefreshHeaderView refreshView];
    __block productCollectVC*blockSelf=self;
    [_refesh addToScrollView:_tabView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tabView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData];
        
        
    };


}
-(void)getData
{
    [_array removeAllObjects];

    LOADVIEW
    [requestData getData:ASK_PRODUCT_C_URL(USERID) complete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        _dataArray=[dic objectForKey:@"data"];
        LOADREMOVE

        [_refeshDown endRefreshing];
        [_refesh endRefreshing];
        [_tabView reloadData];

        if (_dataArray.count==0) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tabView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有关注哦！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tabView addSubview:tishi];
        }
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    //移除cell上的所有控件。
    for (id obj in cell.contentView.subviews) {
        [obj removeFromSuperview];
    }
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //NSLog(@"%ld",(long)indexPath.row);
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];


    NSString*pro_image=[dic objectForKey:@"productImage"];
    NSString*pro_name=[dic objectForKey:@"productName"];
    NSString*shopDesc=[dic objectForKey:@"shopDesc"];
     NSString*categoryName=[dic objectForKey:@"categoryName"];
     //NSString*productSubName=[dic objectForKey:@"productSubName"];

    UIImageView*doct=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.02, _width*0.03, _width*0.25, _width*0.25)];
    [doct sd_setImageWithURL:[NSURL URLWithString:pro_image] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {

            image = [UIImage imageNamed: @"fang"];
        }else{
            float  W=(_width*0.25)*image.size.width/image.size.height;

            doct.frame = CGRectMake((_width*0.25-W)/2, _width*0.03, W, _width*0.25);
            

        }

    }];
    doct.clipsToBounds=YES;
//    doct.layer.cornerRadius=_width*0.125;
    [cell.contentView addSubview:doct];
    
    UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, _width*0.03, _width*0.65, _width*0.07)];
    name_L.text=pro_name;
    name_L.numberOfLines=0;
    name_L.textAlignment=NSTextAlignmentLeft;
    name_L.textColor=[UIColor blackColor];
    name_L.font=[UIFont boldSystemFontOfSize:14];
//    NSString*name=[NSString stringWithFormat:@"%@",pro_name];

//    NSMutableAttributedString*atts2=[[NSMutableAttributedString alloc]initWithString:name];
//    [atts2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:17] range:NSMakeRange(0, pro_name.length)];
//    [atts2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, pro_name.length)];
//    name_L.attributedText=atts2;
    [cell.contentView addSubview:name_L];


    UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, _width*0.1, _width*0.69, _width*0.19)];
    //price_L.text=[NSString stringWithFormat:@"预约费：%@",pro_price];
    price_L.numberOfLines=0;
    price_L.textAlignment=NSTextAlignmentLeft;
    price_L.textColor=[UIColor grayColor];
    price_L.font=[UIFont italicSystemFontOfSize:13];

//    NSString*yuyue=[NSString stringWithFormat:@"￥%.2f",[pro_price doubleValue]];
//    NSMutableAttributedString*atts1=[[NSMutableAttributedString alloc]initWithString:yuyue];
//    [atts1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:14] range:NSMakeRange(0, 4)];
//    [atts1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    price_L.text=[NSString stringWithFormat:@"\t%@",shopDesc];
;
//    [cell.contentView addSubview:price_L];


    UILabel*shanchang_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.33, _width*0.14, _width*0.53, _width*0.06)];
    //shanchang_L.text=[NSString stringWithFormat:@"预约费：%@",pro_price];
    shanchang_L.numberOfLines=1;
    shanchang_L.textAlignment=NSTextAlignmentLeft;
    shanchang_L.textColor=[UIColor darkGrayColor];
    shanchang_L.font=[UIFont systemFontOfSize:14];


    NSString*yuyue1=[NSString stringWithFormat:@"擅长：%@",categoryName];
    NSMutableAttributedString*atts11=[[NSMutableAttributedString alloc]initWithString:yuyue1];
    [atts11 addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:15] range:NSMakeRange(0, 3)];
    [atts11 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    shanchang_L.attributedText=atts11;
//    [cell.contentView addSubview:shanchang_L];

    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, _width*0.31-1, _width*0.96, 1)];
    line.backgroundColor=RGB(234, 234, 234);
    [cell.contentView addSubview:line];

//添加商品信息。
    UILabel*price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, _width*0.12, _width*0.65, _width*0.1)];
    price.text=[NSString stringWithFormat:@"￥%.2f",[dic[@"ratePrice"] doubleValue]];
    price.numberOfLines=0;
    price.textAlignment=NSTextAlignmentLeft;
    price.textColor=[UIColor orangeColor];
    price.font=[UIFont systemFontOfSize:16];
    [cell.contentView addSubview:price];


    UILabel*showClicks=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, _width*0.2, _width*0.3, _width*0.08)];
    showClicks.text=[NSString stringWithFormat:@"人气:%@",dic[@"showClicks"]];
    showClicks.numberOfLines=0;
    showClicks.textAlignment=NSTextAlignmentLeft;
    showClicks.textColor=[UIColor lightGrayColor];
    showClicks.font=[UIFont systemFontOfSize:12];
    [cell.contentView addSubview:showClicks];

    UILabel*salesQuality=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.53, _width*0.2, _width*0.3, _width*0.08)];
    salesQuality.text=[NSString stringWithFormat:@"销量:%@",dic[@"salesQuality"]];
    salesQuality.numberOfLines=0;
    salesQuality.textAlignment=NSTextAlignmentLeft;
    salesQuality.textColor=[UIColor lightGrayColor];
    salesQuality.font=[UIFont systemFontOfSize:12];
    [cell.contentView addSubview:salesQuality];



    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _width*0.31;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSString*shopId=[dic objectForKey:@"productId"];
    PUSH(productVC)
    NSLog(@"---%@",shopId);
    vc.productId=shopId;

}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    if ([tableView isEqual:_tabView]) {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    }
    return result;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //
//         [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
        NSString*colId=[dic objectForKey:@"colId"];
        NSLog(@"%@",dic);
        [requestData getData:DELETE_COLLECT(colId) complete:^(NSDictionary *dic) {
            if ([[dic objectForKey:@"flag"] intValue]==1) {
                [self getData];
            }else
            {

            }
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
        }];
        [self getData];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    [self getData];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)backClick

{
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
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
