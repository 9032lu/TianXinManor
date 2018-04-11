//
//  setHelpcenterVC.m
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "setHelpcenterVC.h"
#import "HelpVC.h"

@interface setHelpcenterVC ()

@end

@implementation setHelpcenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"帮助中心")


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
   // _tableView.rowHeight=40;
    _tableView.bounces=NO;

    [self.view addSubview:_tableView];

     NSLog(@"%@",USER_HELPCENTER);
    LOADVIEW
    [requestData getData:USER_HELPCENTER complete:^(NSDictionary *dic) {
        LOADREMOVE
        NSLog(@"%@",dic);

        _dataArray=[dic objectForKey:@"data"];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 ) {
        return 45;
    }else
    {
        NSString*helpContent=[[_dataArray objectAtIndex:indexPath.section] objectForKey:@"helpContent"];
        CGSize size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:helpContent WithFont:[UIFont systemFontOfSize:14]];
        return size.height+30;

    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }
    NSString*title=[[_dataArray objectAtIndex:indexPath.section] objectForKey:@"title"];
    NSString*helpContent=[[_dataArray objectAtIndex:indexPath.section] objectForKey:@"helpContent"];
    if (indexPath.row==0) {


        cell.textLabel.text=[NSString stringWithFormat:@"%d.%@",indexPath.section+1,title];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
    }


    NSString* headerData=helpContent;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
   // headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (indexPath.row==1) {
        CGSize size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:helpContent WithFont:[UIFont systemFontOfSize:14]];
        UILabel*help_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 10, _width*0.9, size.height)];
        help_L.text=headerData;
        help_L.numberOfLines=0;
        help_L.textColor=[UIColor darkGrayColor];
        help_L.textAlignment=NSTextAlignmentLeft;
        help_L.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:help_L];

    }


    return cell;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*helpContent=[[_dataArray objectAtIndex:indexPath.section] objectForKey:@"helpContent"];

    NSString* headerData=helpContent;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];

    PUSH(HelpVC)
    vc.context =headerData;

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
