//
//  setAboutVC.m
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "setAboutVC.h"

@interface setAboutVC ()

@end

@implementation setAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"关于我们")


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=40;
    _tableView.bounces=YES;
    [self.view addSubview:_tableView];


    [requestData getData:ABOUT_WENWAN_URL complete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        _dic=[dic objectForKey:@"data"];
        [_tableView reloadData];
    }];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0) {
        return 15;
    }else
    {
        return 7.5;
    }



}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<3) {
         return 30;
    }else if(indexPath.row==3)
    {
        return 60;
    }else if(indexPath.row==4)
    {
        return _height-64-20-90-50;
    }else
    {
        return 60;
    }

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    tableView.separatorColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    UILabel*shopL=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.1, 0, _width*0.8, 30)];
    shopL.textAlignment=NSTextAlignmentLeft;
    shopL.textColor=[UIColor darkGrayColor];
    shopL.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:shopL];

   

    if (indexPath.row==0) {
        shopL.text=[NSString stringWithFormat:@"联系人：%@",[_dic objectForKey:@"linker"]];
    }
    if (indexPath.row==1) {
        shopL.text=[NSString stringWithFormat:@"联系电话：%@",[_dic objectForKey:@"linkPhone"]];
    }
    if (indexPath.row==2) {
        shopL.text=[NSString stringWithFormat:@"邮箱：%@",[_dic objectForKey:@"email"]];

    }
    if (indexPath.row==3) {
        shopL.text=[NSString stringWithFormat:@"公司地址：%@",[_dic objectForKey:@"address"]];
        shopL.frame=CGRectMake(_width*0.1, 0, _width*0.8, 50);
        shopL.numberOfLines=0;

    }
    if (indexPath.row==4) {

//          shopL.text=[NSString stringWithFormat:@"公司地址：%@",[_dic objectForKey:@"address"]];
//


        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake((_width-150)/2, 0, 150, 150)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"QRcode"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        }];
        [cell.contentView addSubview:imageView];



    }

    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


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
