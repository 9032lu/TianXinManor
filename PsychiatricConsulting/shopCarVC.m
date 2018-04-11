//
//  shopCarVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "shopCarVC.h"
#import "sureOrderVC.h"
#import "logInVC.h"
@interface shopCarVC ()

@end

@implementation shopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TOP_VIEW(@"购物车")

//    float tabH;
    _currentCarId=[[NSMutableArray alloc]init];

//    if ([self.whoPush isEqualToString:@"xiangqing"]) {
//        self.tabBarController.tabBar.hidden=YES;
//        tabH=0;
//    }else
//    {
//    if ([self.whoPush isEqualToString:@"wode"]) {
        self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=YES;
        backTi.hidden=NO;
        backBtn.hidden=NO;
//    }else{
//        self.tabBarController.tabBar.hidden=NO;
//        backTi.hidden=YES;
//        backBtn.hidden=YES;
//    }


//        tabH=self.tabBarController.tabBar.frame.size.height;
//    }

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];

    _refesh=[SDRefreshHeaderView refreshView];
    __block shopCarVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData];
        
        
    };


}
-(void)getData
{
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    NSLog(@"%@",ASK_SHOP_CAR_URL(USERID));
    LOADVIEW
    [requestData getData:ASK_SHOP_CAR_URL(USERID) complete:^(NSDictionary *dic) {
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        LOADREMOVE
        _dataArray=[dic objectForKey:@"data"];
        [_tableView reloadData];
        if (_dataArray.count==0||_dataArray==nil) {
            if (_dataArray.count==0) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-60)/2, (_height-260)/2, 60,60)];
                tanhao.image=[UIImage imageNamed:@"shopping_car_null"];
                [_tableView addSubview:tanhao];

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+80, _width, 20)];
                tishi.text=@"购物车还没有东西哦，快去添加吧..";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];

                tanhao.tag=22222;
                tishi.tag=222222;
                
            }
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 0.1;
    }
    if (indexPath.row==1) {
        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
        NSArray*productA=[dic objectForKey:@"goods"];
        return _width*0.3*productA.count;
    }else
    {
        return 50;
    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.1;
    }else
    {
        return 15;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    if (indexPath.row==0) {
//        id shopLogo=[dic objectForKey:@"shopLogo"];
//        if (shopLogo==[NSNull null]) {
//            shopLogo=nil;
//        }
//        NSString* shopName=[dic objectForKey:@"shopName"];
//
//        UIButton*selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        selectBtn.frame=CGRectMake(0, 0, 25, 50);
//        [selectBtn setImage:[UIImage imageNamed:@"default1"] forState:UIControlStateNormal];
//        [selectBtn setImage:[UIImage imageNamed:@"default2"] forState:UIControlStateSelected];
//        if (allSelected==YES) {
//            selectBtn.selected=YES;
//        }
//        [selectBtn addTarget:self action:@selector(sectionSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        selectBtn.tag=indexPath.section;
//        [selectBtn setImageEdgeInsets:UIEdgeInsetsMake((50-12)/2, (25-12)/2, (50-12)/2, (25-12)/2)];
//        [cell.contentView addSubview:selectBtn];
//
//        UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(25, 5, 40,40)];
//        [imageview sd_setImageWithURL:[NSURL URLWithString:shopLogo] placeholderImage:[UIImage imageNamed:@"morentu.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        }];
//        imageview.layer.cornerRadius=2;
//        imageview.clipsToBounds=YES;
//        [cell.contentView addSubview:imageview];
//
//
//        UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(70, 0, _width*0.7, 50)];
//        name_L.text=shopName;
//        name_L.numberOfLines=0;
//        name_L.textAlignment=NSTextAlignmentLeft;
//        name_L.textColor=[UIColor darkGrayColor];
//        name_L.font=[UIFont boldSystemFontOfSize:15];
//        [cell.contentView addSubview:name_L];
//
//
//    }
    if (indexPath.row==1) {
        NSArray*productA=[dic objectForKey:@"goods"];

        cell.contentView.tag=indexPath.section;


        for (int i=0; i<productA.count; i++) {
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.3*i, _width, _width*0.28)];
            view.tag=indexPath.section;

            [cell.contentView addSubview:view];

            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
            line.backgroundColor =RGB(234, 234, 234);
            [view addSubview:line];

            UIButton*selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame=CGRectMake(0, _width*0.3*i, _width*0.1, _width*0.3);
            [selectBtn setImage:[UIImage imageNamed:@"default1"] forState:UIControlStateNormal];
            [selectBtn setImage:[UIImage imageNamed:@"default2"] forState:UIControlStateSelected];
            [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];

            selectBtn.tag=i;
            if (sectionSelected==YES) {
                selectBtn.selected=YES;
            }
            [selectBtn setImageEdgeInsets:UIEdgeInsetsMake((_width*0.3-12)/2, (_width*0.1-12)/2, (_width*0.3-12)/2, (_width*0.1-12)/2)];
            [cell.contentView addSubview:selectBtn];


            NSDictionary*gdic=[productA objectAtIndex:i];

            NSString*productImage=[gdic objectForKey:@"productImage"];
            NSString*count=[gdic objectForKey:@"count"];
            NSString*ratePrice=[gdic objectForKey:@"ratePrice"];
            NSString*productName=[gdic objectForKey:@"productName"];


            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.1, _width*0.05, _width*0.2, _width*0.2)];
            [imageview sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!image) {

                    image = [UIImage imageNamed: @"fang"];
                }else{
                float  W=(_width*0.2)*image.size.width/image.size.height;
                imageview.frame = CGRectMake(_width*0.175, _width*0.05, W, _width*0.2);
                }
            }];
//            imageview.layer.cornerRadius=2;
            imageview.clipsToBounds=YES;
            [view addSubview:imageview];
            UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.32, _width*0.05, _width*0.4, _width*0.12)];
            name_L.text=productName;
            name_L.numberOfLines=0;
            name_L.textAlignment=NSTextAlignmentLeft;
            name_L.textColor=[UIColor darkGrayColor];
            name_L.font=[UIFont boldSystemFontOfSize:15];
            [view addSubview:name_L];


            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.72, _width*0.05, _width*0.26, _width*0.06)];
            price_L.text=[NSString stringWithFormat:@"￥%.2f",[ratePrice doubleValue]];
            price_L.numberOfLines=1;
            price_L.textAlignment=NSTextAlignmentRight;
            price_L.textColor=[UIColor orangeColor];
            price_L.font=[UIFont systemFontOfSize:14];
            [view addSubview:price_L];



            UILabel*shop_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.82, _width*0.11, _width*0.16, _width*0.06)];
            shop_L.text=[NSString stringWithFormat:@"x%@",count];
            shop_L.numberOfLines=1;
            shop_L.textAlignment=NSTextAlignmentRight ;
            shop_L.textColor=[UIColor grayColor];
            shop_L.font=[UIFont systemFontOfSize:14];
            [view addSubview:shop_L];
        }



    }
    if (indexPath.row==2) {

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        line.backgroundColor =RGB(234, 234, 234);
        [cell.contentView addSubview:line];
        double total=0;
        NSArray*productA=[dic objectForKey:@"goods"];
        for (int i=0; i<productA.count; i++) {
            NSDictionary*gdic=[productA objectAtIndex:i];
            double count=[[gdic objectForKey:@"count"] doubleValue];
            double ratePrice=[[gdic objectForKey:@"ratePrice"] doubleValue];

            total=total+count*ratePrice;
        }

        UILabel*shop_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.45, 50)];
        shop_L.text=[NSString stringWithFormat:@"共计：%.2f",total];
        shop_L.numberOfLines=1;
        shop_L.textAlignment=NSTextAlignmentLeft ;
        shop_L.textColor=[UIColor grayColor];
        shop_L.font=[UIFont systemFontOfSize:14];
        //[cell.contentView addSubview:shop_L];


        UIButton*delete=[UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame=CGRectMake(_width*0.6, 10, _width*0.15, 30);
        [delete addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        delete.tag=indexPath.section;
        delete.backgroundColor=APP_ClOUR;
        delete.layer.cornerRadius=5;
        [delete setTitle:@"删除" forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:delete];


        UIButton*jisuan=[UIButton buttonWithType:UIButtonTypeCustom];
        jisuan.frame=CGRectMake(_width*0.8, 10, _width*0.15, 30);
        [jisuan addTarget:self action:@selector(jisuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        jisuan.tag=indexPath.section;
        jisuan.backgroundColor=APP_ClOUR;
        jisuan.layer.cornerRadius=5;
        [jisuan setTitle:@"结算" forState:UIControlStateNormal];
        [jisuan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:jisuan];


    }

    return cell;
}
-(void)deleteBtnClick:(UIButton*)button
{
    [_currentCarId removeAllObjects];
    NSIndexPath*path=[NSIndexPath indexPathForRow:1 inSection:button.tag];
    UITableViewCell*cell=[_tableView cellForRowAtIndexPath:path];


    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
    NSArray*productA=[dic objectForKey:@"goods"];

    int i=0;
    for (UIView*manyView in cell.contentView.subviews) {

        if ([manyView isKindOfClass:[UIButton class]]) {
            UIButton*lastBtn=(UIButton*)manyView;
            if (lastBtn.selected) {
                i++;
                NSString*carId=[[productA objectAtIndex:lastBtn.tag] objectForKey:@"cartId"];
                [_currentCarId addObject:carId];

            }

        }
    }
  NSLog(@"%@-",_currentCarId);
    if (i==0) {
        ALERT(@"请选择商品")

    }else
    {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"是否确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate=self;
        [alert show];

    }






}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%@",[_currentCarId objectAtIndex:0]);
    if (buttonIndex==1) {
        for (int i=0; i<_currentCarId.count; i++) {
            [requestData getData:DELETE_SHOP_CAR_URL([_currentCarId objectAtIndex:i]) complete:^(NSDictionary *dic) {
                if ([[dic objectForKey:@"flag"] intValue]==1) {
                    [self getData];
                }else
                {
                    ALERT([dic objectForKey:@"info"]);
                }
            }];



        }
    }
}
-(void)jisuanBtnClick:(UIButton*)button
{

    NSIndexPath*path=[NSIndexPath indexPathForRow:1 inSection:button.tag];
    UITableViewCell*cell=[_tableView cellForRowAtIndexPath:path];



    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
    id shopLogo=[dic objectForKey:@"shopLogo"];
    if (shopLogo==[NSNull null]) {
        shopLogo=nil;
    }
    NSString* shopName=[dic objectForKey:@"shopName"];
    NSString* shopId=[dic objectForKey:@"shopId"];

    NSMutableDictionary*mudic=[[NSMutableDictionary alloc]init];

    NSMutableArray*goodArry=[[NSMutableArray alloc]initWithCapacity:0];


    [mudic setObject:shopId forKey:@"shopId"];
    if (shopLogo==nil) {
        [mudic setObject:@"" forKey:@"shopLogo"];
    }else
    {
        [mudic setObject:shopLogo forKey:@"shopLogo"];
    }

    [mudic setObject:shopName forKey:@"shopName"];

     int i=0;

    for (id  button1 in cell.contentView.subviews) {
        if ([button1 isKindOfClass:[UIButton class]]) {
            UIButton*btn=(UIButton*)button1;
            NSLog(@"hhhhhhhhhh");
            if (btn.selected) {
                NSMutableDictionary*productDic=[[NSMutableDictionary alloc]init];

                NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
                NSArray*productA=[dic objectForKey:@"goods"];
                NSDictionary*goodDic=[productA objectAtIndex:btn.tag];


                NSString*imagePath=[goodDic objectForKey:@"productImage"];
                NSString*productId=[goodDic objectForKey:@"productId"];
                NSString*productName=[goodDic objectForKey:@"productName"];
                NSString*productQuantity=[goodDic objectForKey:@"productQuantity"];
                NSString*ratePrice=[goodDic objectForKey:@"ratePrice"];
                NSString*count=[goodDic objectForKey:@"count"];

                [productDic setObject:productId forKey:@"productId"];
                [productDic setObject:imagePath forKey:@"imagePath"];
                [productDic setObject:productName forKey:@"productName"];
                [productDic setObject:ratePrice forKey:@"ratePrice"];
                [productDic setObject:productQuantity forKey:@"productQuantity"];
                [productDic setObject:count forKey:@"count"];



                [goodArry addObject:productDic];

            }else
            {
                i++;


            }
        }
    }
     NSArray*productA=[dic objectForKey:@"goods"];
    if (i==productA.count) {
        ALERT(@"请选择商品")
        return;
    }

// NSLog(@"%@--%d---%d-",productA,i,productA.count);


    NSDictionary*postDic=@{@"shop":mudic,@"good":goodArry};



    PUSH(sureOrderVC)
    vc.InfoArray=postDic;
    self.tabBarController.tabBar.hidden=YES;


}
-(void)selectBtnClick:(UIButton*)button
{
    if (button.selected) {
        button.selected=NO;

        
    }else
    {
//        NSIndexPath*patho=[NSIndexPath indexPathForRow:0 inSection:button.tag];
//        sectionSelected=YES;
//        [_tableView reloadRowsAtIndexPaths:@[patho] withRowAnimation:NO];
        button.selected=YES;
    }
    UIView*view=[button superview];
    NSDictionary*dic=[_dataArray objectAtIndex:view.tag];
    NSArray*productA=[dic objectForKey:@"goods"];
   // NSLog(@"%d=====",productA.count);
    //NSIndexPath*path=[NSIndexPath indexPathForRow:1 inSection:view.tag];

    int i=0;
    for (UIView*manyView in view.subviews) {

        if ([manyView isKindOfClass:[UIButton class]]) {
            UIButton*lastBtn=(UIButton*)manyView;
            if (lastBtn.selected) {
                i++;
            }

        }
    }
    NSLog(@"%d-----",i);
    if (i==productA.count) {
        allSelected=YES;
        sectionSelected=YES;
        NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:view.tag];
        [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }else
    {
        allSelected=NO;
        sectionSelected=NO;
        NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:view.tag];
        [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

    }




}
-(void)sectionSelectBtnClick:(UIButton*)button
{
    if (button.selected) {
        button.selected=NO;
        sectionSelected=NO;
        NSIndexPath*path=[NSIndexPath indexPathForRow:1 inSection:button.tag];
        UITableViewCell*cell=[_tableView cellForRowAtIndexPath:path];
        for (id  button1 in cell.contentView.subviews) {
            if ([button1 isKindOfClass:[UIButton class]]) {
                UIButton*btn=(UIButton*)button1;
                btn.selected=NO;
                [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:NO];

            }
        }


    }else
    {
        sectionSelected=YES;

        NSIndexPath*path=[NSIndexPath indexPathForRow:1 inSection:button.tag];
        UITableViewCell*cell=[_tableView cellForRowAtIndexPath:path];
        for (id  button in cell.contentView.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                UIButton*btn=(UIButton*)button;
                btn.selected=YES;
                [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:NO];


            }
        }

        button.selected=YES;
    }

}
-(void)viewWillAppear:(BOOL)animated
{

     [super viewWillAppear:animated];
//    if (USERID==nil) {
//
//        PUSH(logInVC)
//        [self presentViewController:vc animated:NO completion:^{
//
//        }];
//
//    }else
//    {
        [self getData];

//    }

}
-(void)backClick{
    POP
    NSLog(@"back");
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
