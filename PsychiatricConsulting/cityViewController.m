//
//  cityViewController.m
//  PsychiatricConsulting
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "cityViewController.h"
#import "danli.h"
#import "firstPage.h"

@interface cityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView*_tableView;

    NSArray     *_dataArray;


}

@end

@implementation cityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"城市选择")

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=55;
    [self.view addSubview:_tableView];


//    danli*myapp=[danli shareClient];
//    myapp.cityIsChange=YES;

    [self getData];
}
-(void)getData
{
    LOADVIEW
    NSString *city = @"重庆市";
    [requestData getData:GET_DISTRUCT(city) complete:^(NSDictionary *dic) {
        LOADREMOVE
        _dataArray=[dic objectForKey:@"data"];

        [_tableView reloadData];

     }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 0;
//    }else
//    {

        return _dataArray.count;
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width, 40)];
    label.font=[UIFont systemFontOfSize:16];
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor whiteColor];
    label.textColor=[UIColor darkGrayColor];
    label.backgroundColor=RGB(234, 234, 234);
//    if (section==0) {
        label.text=@"\t重庆市";
//    }else
//    {
//        label.text=@"\t全部地区";
//    }
    UIButton *button = [[UIButton alloc]initWithFrame:label.frame];
    [button addTarget:self action:@selector(butto) forControlEvents:UIControlEventTouchUpInside];

    [button addSubview:label];
    return button;
}
-(void)butto{
//    NSLog(@"------");
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"selectCity"];

    POP;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    UIImageView*rightA=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 15)];
//    rightA.image=[UIImage imageNamed:@"arrow_right"];
//    cell.accessoryView=rightA;
//    if (indexPath.section==0) {
//        cell.textLabel.text=[NSString stringWithFormat:@"\t%@",CURRENT_CITY];
//    }else
//    {

        cell.textLabel.text=[NSString stringWithFormat:@"\t%@",[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"districtName"]];
//    }
//    NSLog(@"+++%@",_dataArray);
     cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.textColor=[UIColor blackColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0) {
//        [[NSUserDefaults standardUserDefaults] setObject:CURRENT_CITY forKey:@"selectCity"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }else
//    {
        NSString*cityName=[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"districtName"];
    NSString *disId = [[_dataArray objectAtIndex:indexPath.row]objectForKey:@"districtId"];

    [[NSUserDefaults standardUserDefaults]setObject:disId forKey:@"districtId"];
    [[NSUserDefaults standardUserDefaults] synchronize];

        [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"selectCity"];
        [[NSUserDefaults standardUserDefaults] synchronize];

//    }
    POP
}
-(void)backClick
{
    POP
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
