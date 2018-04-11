//
//  categtoryListVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15-5-7.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "categtoryListVC.h"
#import "newProductListVC.h"
@interface categtoryListVC ()

@end

@implementation categtoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"分类")



    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=50;
    [self.view addSubview:_tableView];
    [self getData];
}
-(void)getData
{
    [requestData getData:SUBLIST_URL(@"0") complete:^(NSDictionary *dic) {
//        NSLog(@"%@",dic);
        _dataArray=[dic objectForKey:@"data"];
        [_tableView reloadData];
    }];

    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];

    cell.textLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryName"]];
    cell.textLabel.font=[UIFont systemFontOfSize:15];



    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*categoryId=[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"categoryId"];
    PUSH(newProductListVC)

    vc.whoPush=@"class";
    vc.cagetoryId=categoryId;
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
