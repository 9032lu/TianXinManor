//
//  MyOrderViewController.m
//  PsychiatricConsulting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "MyOrderViewController.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
SCREEN_WIDTH_AND_HEIGHT
    UITableView             *_tableView;
    UIButton                *_lastBtn;
    UIView                  *_moveView;

    NSArray                 *_shopArray;


}
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SCREEN
    TOP_VIEW(@"我的订单");

    NSArray*nameArray=@[@"我的订单",@"历史订单"];
    for (int i=0; i<2; i++) {
        UIButton*orderBtn=[[UIButton alloc]initWithFrame:CGRectMake(_width/2*i, 64, _width/2, 50)];
        [orderBtn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [orderBtn setTitleColor:APP_ClOUR forState:UIControlStateSelected];
        [orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        orderBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        orderBtn.tag=i;
        if (i==0) {
            orderBtn.selected=YES;
            _lastBtn=orderBtn;
        }
        [orderBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:orderBtn];
    }

    _moveView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+46, _width/2, 4)];
    _moveView.backgroundColor=APP_ClOUR;
    [self.view addSubview:_moveView];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, _width, _height-64-50) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];

    _shopArray=@[@"",@""];
    // Do any additional setup after loading the view.
}
-(void)selectBtnClick:(UIButton*)button
{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;

    [UIView animateWithDuration:0.3 animations:^{
        _moveView.frame=CGRectMake(_width/2*button.tag, 64+46, _width/2, 4);
    } completion:^(BOOL finished) {

    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shopArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return _width*0.2+20;
    }else
    {
        return _width*0.25+20;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {


        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.02, 10, _width*0.2, _width*0.2)];
        imageView.image=[UIImage imageNamed:@"fang"];
        [cell.contentView addSubview:imageView];

        UILabel*collect_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 10, _width*0.65, _width*0.2)];
        collect_L.textAlignment=NSTextAlignmentLeft;
        collect_L.textColor=APP_ClOUR;
        collect_L.text=@"花家怡园";
        collect_L.font=[UIFont boldSystemFontOfSize:17];
        [cell.contentView addSubview:collect_L];

    }else
    {
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 10, _width*0.3, _width*0.25)];
        imageView.image=[UIImage imageNamed:@"chang"];
        imageView.layer.cornerRadius=5;
        imageView.clipsToBounds=YES;
        [cell.contentView addSubview:imageView];

        UILabel*product_name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.34, 10, _width*0.46, _width*0.15)];
        product_name.textAlignment=NSTextAlignmentLeft;
        product_name.textColor=[UIColor darkGrayColor];
        product_name.numberOfLines=0;
        product_name.text=@"私房菜四川美食自贡特产 冷吃兔 麻辣兔肉丁";
        product_name.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:product_name];

        UILabel*product_number=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.34, _width*0.15+10, _width*0.46, _width*0.1)];
        product_number.textAlignment=NSTextAlignmentLeft;
        product_number.textColor=[UIColor darkGrayColor];
        product_number.numberOfLines=1;
        product_number.text=@"数量：1份";
        product_number.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:product_number];

        UILabel*product_price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.5, _width*0.15+10, _width*0.45, _width*0.1)];
        product_price.textAlignment=NSTextAlignmentRight;
        product_price.textColor=APP_ClOUR;
        product_price.numberOfLines=1;
        product_price.text=@"￥19";
        product_price.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:product_price];



    }

    return cell;
}
-(void)backClick
{
    POP
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
