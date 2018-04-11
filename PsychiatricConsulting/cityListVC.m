//
//  cityListVC.m
//  logRegister
//
//  Created by apple on 15-2-2.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "cityListVC.h"


@interface cityListVC ()

@end

@implementation cityListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"城市列表")

        _zimuArray=@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];


    NSString*city=[NSString stringWithFormat:@"您当前所在城市：%@",CURRENT_CITY];

    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(_width*0.03, 64, _width, 40);

    [button addTarget:self action:@selector(hotBack) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    button.layer.cornerRadius=5;
    [button setTitle:city forState:UIControlStateNormal];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:button];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, _width-20, _height-64-40) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=40;


    _tableView.sectionIndexColor=RGB(119, 82, 32);
    _tableView.sectionIndexBackgroundColor=[UIColor whiteColor];

    [self.view addSubview:_tableView];

    for (int i=0; i<22; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width-30, 64+i*(_height-64)/22, 30, (_height-64)/22);
        button.backgroundColor=[RGB(150, 150, 150) colorWithAlphaComponent:0.5];
        [button setTitle:[_zimuArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightKeyClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        button.tag=i;
        [self.view addSubview:button];

    }
    _lastChar=@"9";
    _keysArray=[[NSMutableDictionary alloc]init];

    [self getData];
    

}
-(void)hotBack
{
    if (CURRENT_CITY) {
        [[NSUserDefaults standardUserDefaults] setObject:CURRENT_CITY forKey:@"selectCity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else
    {
        //ALERT(@"请选择城市")
    }
    POP
    self.tabBarController.tabBar.hidden=YES;
}
-(void)getData
{
    LOADVIEW

     [requestData getData:GET_CITY complete:^(NSDictionary *dic) {
//         NSLog(@"%@",dic);
         LOADREMOVE
         NSArray*array=[dic objectForKey:@"data"];
         for (int i=0; i<_zimuArray.count; i++) {
             NSMutableArray*cityA=[[NSMutableArray alloc]init];

             for (int j=0; j<array.count; j++) {
                 NSDictionary*cityDic=[array objectAtIndex:j];
                
                 NSString*firstChar=[cityDic objectForKey:@"firstChar"];

                 if ([firstChar isEqualToString:[_zimuArray objectAtIndex:i]]) {
                     [cityA addObject:cityDic];
                     [_keysArray setObject:cityA forKey:[_zimuArray objectAtIndex:i]];
                 }
             }


     }
//                  NSLog(@"%@",_keysArray);
         [_tableView reloadData];

    }];

}

-(BOOL)shouldAutorotate
{
    return NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }else
    {
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
-(void)rightKeyClick:(UIButton*)button
{
    
    NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:button.tag];

    [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keysArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray*array=[_keysArray objectForKey:[_zimuArray objectAtIndex:section]];

    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];


    NSArray *cityDic = [_keysArray objectForKey:[_zimuArray objectAtIndex:indexPath.section]];
    NSDictionary*dic=[cityDic objectAtIndex:indexPath.row];
    //NSString*cityId=[dic objectForKey:@"cityId"];
    NSString*cityName=[dic objectForKey:@"cityName"];
    NSString*isPass=[dic objectForKey:@"isPass"];
    cell.textLabel.text=cityName;
    cell.textLabel.font=[UIFont systemFontOfSize:14];

    if ([isPass intValue]==1) {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.8-50, 0, _width*0.2, 40)];
        label.text=@"已开通";
        label.font=[UIFont systemFontOfSize:14];
        label.textColor=[UIColor redColor];
        label.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cityDic = [_keysArray objectForKey:[_zimuArray objectAtIndex:indexPath.section]];
    NSDictionary*dic=[cityDic objectAtIndex:indexPath.row];
    //NSString*cityId=[dic objectForKey:@"cityId"];
    NSString*cityName=[dic objectForKey:@"cityName"];
//    NSLog(@"%@",cityName);

    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"selectCity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    POP
    self.tabBarController.tabBar.hidden=YES;




}
-(void)twoTap:(UITapGestureRecognizer*)tap
{


}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 30)];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0,50, 30)];
   label.text=[_zimuArray objectAtIndex:section];
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor redColor];
    //label.backgroundColor=[UIColor greenColor];
    label.font=[UIFont systemFontOfSize:18];
    [view addSubview:label];
    return view;
}


-(void)backClick
{
    if (CURRENT_CITY) {
        [[NSUserDefaults standardUserDefaults] setObject:CURRENT_CITY forKey:@"selectCity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
       // ALERT(@"请选择城市")
    }

    POP
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
