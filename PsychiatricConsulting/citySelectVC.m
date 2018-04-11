//
//  citySelectVC.m
//  logRegister
//
//  Created by apple on 15-3-3.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "citySelectVC.h"

@interface citySelectVC ()

@end

@implementation citySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"选择省市区")

    self.view.backgroundColor = [UIColor whiteColor];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 130, _width, _height-130) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];


    UILabel*alter=[[UILabel alloc]init];
    alter.frame=CGRectMake(0, 64, _width*0.35, 36);
    alter.font=[UIFont systemFontOfSize:14];
   // alter.backgroundColor=RGB(244, 244, 244);
    alter.text=@"   编辑已选条件：";
    alter.textAlignment=NSTextAlignmentLeft;
    alter.textColor=[UIColor darkGrayColor];
    [self.view addSubview:alter];

    _address_L=[[UILabel alloc]init];
    _address_L.frame=CGRectMake(_width*0.35, 67, 0, 30);
    _address_L.font=[UIFont systemFontOfSize:14];
    _address_L.backgroundColor=RGB(244, 244, 244);
    _address_L.textAlignment=NSTextAlignmentCenter;
    _address_L.textColor=[UIColor darkGrayColor];
    [self.view addSubview:_address_L];


    _backUp=[UIButton buttonWithType:UIButtonTypeCustom];
    _backUp.frame=CGRectMake(_width*0.02, 103, _width*0.96, 24);
    [_backUp setTitle:@"返回上一级" forState:UIControlStateNormal];
    [_backUp setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _backUp.backgroundColor=RGB(244, 244, 244);
    _backUp.titleLabel.font=[UIFont systemFontOfSize:14];
    [_backUp addTarget:self action:@selector(backUp) forControlEvents:UIControlEventTouchUpInside];
    _backUp.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:_backUp];



    [self getData];


}
-(void)backUp
{
    if (_currentArray==_provinceArray) {

    }
    if (_currentArray==_cityArray) {
        _address_L.text=[NSString stringWithFormat:@"%@",_province];
        _currentArray=_provinceArray;
        [_tableView reloadData];

    }
    if (_currentArray==_distructArray) {
        _address_L.text=[NSString stringWithFormat:@"%@   %@",_province,_city];
        _currentArray=_cityArray;
        [_tableView reloadData];

    }
     _address_L.frame=CGRectMake(_width*0.35, 67, _address_L.text.length*15, 30);
    if (_address_L.text.length>10) {
        _address_L.frame=CGRectMake(_width*0.35, 67, _width*0.63, 30);
        _address_L.adjustsFontSizeToFitWidth=YES;
    }else
    {
        _address_L.adjustsFontSizeToFitWidth=NO;
    }
}
-(void)getData
{

    LOADVIEW

        [requestData getData:GET_PROVINCE_URL complete:^(NSDictionary *dic) {
//            NSLog(@"%@",dic);
            LOADREMOVE
            _provinceArray=[dic objectForKey:@"data"];
            _currentArray=_provinceArray;
            [_tableView reloadData];
            
        }];
//

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentArray.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    [tableView setSeparatorInset:UIEdgeInsetsZero];

    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_currentArray==_provinceArray) {
        cell.textLabel.text=[[_provinceArray objectAtIndex:indexPath.row] objectForKey:@"provinceName"];
    }
    if (_currentArray==_cityArray) {
        cell.textLabel.text=[[_cityArray objectAtIndex:indexPath.row] objectForKey:@"cityName"];
    }
    if (_currentArray==_distructArray) {
        cell.textLabel.text=[[_distructArray objectAtIndex:indexPath.row] objectForKey:@"districtName"];
    }

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentArray==_provinceArray) {
        _city=@"";
        _distruct=@"";
        _province=[[_provinceArray objectAtIndex:indexPath.row] objectForKey:@"provinceName"];

        NSString*provinceId=[[_provinceArray objectAtIndex:indexPath.row] objectForKey:@"provinceId"];
        _province_Id=[[_provinceArray objectAtIndex:indexPath.row] objectForKey:@"provinceId"];
        [requestData getData:GET_CITY_URL(provinceId) complete:^(NSDictionary *dic) {
           // NSLog(@"%@",dic);
            _cityArray=[dic objectForKey:@"data"];
            _currentArray=_cityArray;
            [_tableView reloadData];
        }];
    }
    if (_currentArray==_cityArray) {
        _distruct=@"";

        _city=[[_cityArray objectAtIndex:indexPath.row] objectForKey:@"cityName"];
        _city_Id=[[_cityArray objectAtIndex:indexPath.row] objectForKey:@"cityId"];


        NSString*cityId=[[_cityArray objectAtIndex:indexPath.row] objectForKey:@"cityId"];
//
        [requestData getData:GET_DISTRUCT_URL(cityId) complete:^(NSDictionary *dic) {
//            NSLog(@"%@",dic);
            _distructArray=[dic objectForKey:@"data"];
            _currentArray=_distructArray;
            [_tableView reloadData];
        }];

    }
    if (_currentArray==_distructArray) {
        _distruct=[[_distructArray objectAtIndex:indexPath.row] objectForKey:@"districtName"];
        _distruct_Id=[[_distructArray objectAtIndex:indexPath.row] objectForKey:@"districtId"];


        [[NSNotificationCenter defaultCenter] postNotificationName:@"citySelect" object:nil userInfo:@{@"city":_city,@"provice":_province,@"district":_distruct,@"proviceId":_province_Id,@"cityId":_city_Id,@"districtId":_distruct_Id}];

        //if ([self.present isEqualToString:@"wanshan"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
       //{
          POP

        //}


        



       
    }
    NSLog(@"%@--%@--%@",_province,_city,_distruct);

    if (_city==nil) {
        _city=@"";
    }
    if (_distruct==nil) {
        _distruct=@"";
    }


    _address_L.text=[NSString stringWithFormat:@"%@  %@   %@",_province,_city,_distruct];

    _address_L.frame=CGRectMake(_width*0.35, 67, _address_L.text.length*15, 30);

    if (_address_L.text.length>10) {
        _address_L.frame=CGRectMake(_width*0.35, 67, _width*0.63, 30);
        _address_L.adjustsFontSizeToFitWidth=YES;
    }else
    {
        _address_L.adjustsFontSizeToFitWidth=NO;
    }




}
-(void)backClick
{
    if ([self.present isEqualToString:@"wanshan"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
       POP
    }

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
