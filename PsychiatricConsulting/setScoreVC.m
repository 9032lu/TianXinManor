//
//  setScoreVC.m
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "setScoreVC.h"
#import "transformTime.h"
@interface setScoreVC ()

@end

@implementation setScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    imgArray =@[@"listzhuce",@"listqiandao",@"listfabu",@"listgouwu",];
    NSString *url;

    if ([self.whopush isEqualToString:@"center"]) {
        TOP_VIEW(@"积分明细")
        url = USER_scoreList(USERID);
    }else {
        TOP_VIEW(@"积分规则")
        url = USER_LEVEL;
    }
    NSLog(@"33333==%@",url);

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=40;
    _tableView.bounces=YES;

    [self.view addSubview:_tableView];

    [requestData getData:url complete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        _dataArray=[dic objectForKey:@"data"];
        [_tableView reloadData];
    }];


}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    if ([self.whopush isEqualToString:@"center"]) {
        UILabel *souse = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.15, 0, _width*0.4, 40)];
        souse.textAlignment=NSTextAlignmentLeft;
        souse.textColor=[UIColor darkGrayColor];
        souse.font=[UIFont systemFontOfSize:15];
        souse.text = @"来源";
        [view addSubview:souse];

        UILabel *scoreChange = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.4, 0, _width*0.4, 40)];
        scoreChange.textAlignment=NSTextAlignmentCenter;
        scoreChange.textColor=[UIColor darkGrayColor];
        scoreChange.font=[UIFont systemFontOfSize:15];
        scoreChange.text = @"积分变化";
        [view addSubview:scoreChange];

        UILabel *scoredate = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.65, 0, _width*0.35, 40)];
        scoredate.textAlignment=NSTextAlignmentCenter;
        scoredate.textColor=[UIColor darkGrayColor];
        scoredate.font=[UIFont systemFontOfSize:15];
        scoredate.text = @"日期";
        [view addSubview:scoredate];


    }else{

    }
        return view;


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.whopush isEqualToString:@"center"]) {
        return 40;
    }else{
        return 15;

    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel*levelName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.1, 0, _width*0.4, 40)];
    levelName.textAlignment=NSTextAlignmentLeft;
    levelName.textColor=[UIColor darkGrayColor];
    levelName.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:levelName];


    UILabel*levelScore=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.45, 0, _width*0.52, 40)];
    levelScore.textAlignment=NSTextAlignmentLeft;
    levelScore.textColor=[UIColor grayColor];
    levelScore.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:levelScore];

    if ([self.whopush isEqualToString:@"center"]) {
//积分
        levelScore.font=[UIFont systemFontOfSize:18];
        levelScore.textColor=[UIColor redColor];
        levelScore.frame = CGRectMake(_width*0.53, 0, _width*0.45, 40);
        NSNumber *nub =[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"scoreCount"];
        levelScore.text = [NSString stringWithFormat:@"+%@",nub];
//来源
        levelName.text =[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"scoreSource"];
        levelName.numberOfLines=2;

//时间
        UILabel*leveldate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.65, 0, _width*0.35, 40)];
        leveldate.textAlignment=NSTextAlignmentCenter;
        leveldate.textColor=[UIColor grayColor];
        leveldate.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:leveldate];
        leveldate.text = [transformTime prettyDateWithReference:[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"scoreDate"]];

        UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.1-27,10 , 20, 20)];
        if ((NSNull*)[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"scoreType"]!=[NSNull null]) {

        NSInteger typeid =[[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"scoreType"] integerValue];

//        if (indexPath.row <4) {
//            imagev.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArray[indexPath.row]]];
//
//        }else{
            imagev.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArray[typeid]]];
        }

//        }
        [cell.contentView addSubview:imagev];




    }else{
        NSString*levelNameS=[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"levelName"];
        NSString*levelScoreS=[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"levelScore"];

        NSString*levels;
        if (indexPath.row==0) {
            levels=@"0";
        }else{
            int hh=[[[_dataArray objectAtIndex:indexPath.row-1] objectForKey:@"levelScore"] intValue]+1;
            levels=[NSString stringWithFormat:@"%d",hh];

        }


        levelName.text=[NSString stringWithFormat:@"%@",levelNameS];
        levelScore.text=[NSString stringWithFormat:@"%@~%@等级分",levels,levelScoreS];
        

    }

    return cell;
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
