//
//  QuestionVC.m
//  TianXinManor
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import "QuestionVC.h"
#import "QuestionCell.h"
#import "AskVC.h"
#import "logInVC.h"
@interface QuestionVC ()

@end

@implementation QuestionVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden= YES;
}
-(void)backClick{
    POP
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"商品咨询")
    _dataArray = [[NSMutableArray alloc]init];
    UIButton*rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtn.frame=CGRectMake(_width*0.95-25, 28,25, 20);

    [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"sq9"] forState:UIControlStateNormal];
    [topView addSubview:rightUpBtn];

    rightUpBtnBack=[myButton buttonWithType:UIButtonTypeCustom];
    rightUpBtnBack.frame=CGRectMake(_width*0.85, 0,_width*0.8, 64);
    [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    rightUpBtnBack.isClicked=NO;
    [topView addSubview:rightUpBtnBack];
    _currentId= @"";
_moreId = @"";
    [self getDataWith:@"more"];

//    for (int i =0; i <4; i ++) {
//
//        UIButton*jieshao=[[UIButton alloc]initWithFrame:CGRectMake((_width/4)*i, 64,_width/4 , 50)];
//        [jieshao  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        jieshao.titleLabel.font=[UIFont systemFontOfSize:15];
////        jieshao.layer.cornerRadius = 3;
////        jieshao.clipsToBounds =YES;
//        jieshao.selected = NO;
//        jieshao.tag = i;
//        jieshao.backgroundColor= RGB(255, 255, 255);
//        [jieshao addTarget:self action:@selector(jieshao:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:jieshao];
//
//        [jieshao  setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//
//        if (i ==0) {
//            [jieshao setTitle:@"商品咨询" forState:UIControlStateNormal];
//
//
//            [jieshao  setTitleColor:APP_ClOUR forState:UIControlStateNormal];
//
//            jieshao.selected = YES;
//            oldbutton = jieshao;
//
//        }
//        if (i ==1) {
//            [jieshao setTitle:@"库存配送" forState:UIControlStateNormal];
//
//
//
//        }
//        if (i ==2) {
//            [jieshao setTitle:@"发票" forState:UIControlStateNormal];
//        }
//        if (i ==3) {
//            [jieshao setTitle:@"其他" forState:UIControlStateNormal];
//        }
//
//        if (i>0) {
//            UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 30)];
//            shuxian.backgroundColor=RGB(234, 234, 234);
//            [jieshao addSubview:shuxian];
//
//            
//        }
//    }
//

    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    __block QuestionVC *blockSelf = self;

    _refesh=[SDRefreshHeaderView refreshView];
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getDataWith:@""];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getDataWith:@"more"];


    };

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count !=0) {
        NSDictionary *dic = _dataArray[indexPath.row];
        CGFloat h_content = [self boundWithSize:CGSizeMake(_width-90, MAXFLOAT) WithString:dic[@"askContent"] WithFont:[UIFont systemFontOfSize:14]].height;
        CGFloat h_replay = [self boundWithSize:CGSizeMake(_width-90, MAXFLOAT) WithString:dic[@"replyContent"] WithFont:[UIFont systemFontOfSize:14]].height;

        return 125-16.707*2+h_content+h_replay;

    }else{
        return 0.1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[QuestionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    if (_dataArray.count !=0) {
        NSDictionary *dic = _dataArray[indexPath.row];
        NSString *userId = dic[@"userId"];
        cell.name.text = [NSString stringWithFormat:@"%@****%@",[userId substringToIndex:3],[userId substringFromIndex:7]];
        cell.context_l.text = dic[@"askContent"];
        cell.type_l.text = dic[@"askType"];
        cell.replay_l.text = dic[@"replyContent"];
        NSString *time_p =dic[@"pubDate"];
        cell.time_l.text = [time_p substringToIndex:19];

        NSString *time_R =dic[@"replyDateTime"];
        cell.time_rep.text = [time_R substringToIndex:19];


        CGFloat h_content = [self boundWithSize:CGSizeMake(_width-90, MAXFLOAT) WithString:dic[@"askContent"] WithFont:[UIFont systemFontOfSize:14]].height;

        CGFloat h_replay = [self boundWithSize:CGSizeMake(_width-90, MAXFLOAT) WithString:dic[@"replyContent"] WithFont:[UIFont systemFontOfSize:14]].height;

        CGRect conten_R = cell.context_l.frame ;
        conten_R.size.height =30-16.707+h_content-5;
        cell.context_l.frame = conten_R;

        CGRect rep_O = cell.title_rep.frame;
        rep_O.origin.y=cell.context_l.frame.origin.y +cell.context_l.frame.size.height;
        cell.title_rep.frame = rep_O;

        CGRect replay_R = cell.replay_l.frame;
        replay_R.size.height =30-16.707+h_replay-5;
        replay_R.origin.y = cell.title_rep.frame.origin.y;
        cell.replay_l.frame = replay_R;

        
        CGRect time_Rs = cell.time_title.frame;
        time_Rs.origin.y =cell.replay_l.frame.origin.y +cell.replay_l.frame.size.height;
        cell.time_title.frame = time_Rs;

        CGRect time_SR = cell.time_rep.frame;
        time_SR.origin.y =cell.time_title.frame.origin.y ;
        cell.time_rep.frame = time_SR;


    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)getDataWith:(NSString*)more
{
    LOADVIEW
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];


    NSString*tag=@"1";
    NSDictionary *paramater;
    if ([more isEqualToString:@"more"]) {
        tag = @"2";
        paramater = @{@"tag":tag,@"pageSize":@"12",@"id":_moreId,@"productId":self.productId};

    }else{
        paramater = @{@"tag":tag,@"pageSize":@"12",@"id":_currentId,@"productId":self.productId};

    }
    NSString *url = [NSString stringWithFormat:@"%@/askProduct/list.action",BASE_URLL];
    NSLog(@"+++++++++++%@",paramater);
    [requestData PostData:url Parameters:paramater Completion:^(NSError *error, NSDictionary *resultDict) {


        [_refeshDown endRefreshing];
        [_refesh endRefreshing];
LOADREMOVE
        NSArray*arr=[resultDict objectForKey:@"data"];
        if (arr.count !=0) {
            if ([more isEqualToString:@"more"]) {
                for (int i=0; i<arr.count; i++) {
                    [_dataArray addObject:[arr objectAtIndex:i]];
                }

                _moreId= [self getTheNoNullStr:[[_dataArray lastObject] objectForKey:@"askId"] andRepalceStr:@""];
                _currentId=[self getTheNoNullStr:[_dataArray[0] objectForKey:@"askId"] andRepalceStr:@""];

            }else
            {

                _dataArray=[NSMutableArray arrayWithArray:arr];
                _moreId= [self getTheNoNullStr:[[_dataArray lastObject] objectForKey:@"askId"] andRepalceStr:@""];
                _currentId=[self getTheNoNullStr:[_dataArray[0] objectForKey:@"askId"] andRepalceStr:@""];
            }

        }


        [_tableView reloadData];

        if (_dataArray.count==0) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"暂时还没有相关的问题!";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];
            tanhao.tag=22222;
            tishi.tag=222222;
            
        }
    }];
    
}
-(void)jieshao:(UIButton *)button{
    if (oldbutton !=button) {
        button.selected = YES;

        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [oldbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

//        oldbutton.backgroundColor = RGB(234, 234, 234);
//        [oldbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oldbutton = button;
    }

}
-(void)rightUpBtnClick{
    if (USERID ==nil) {
        ALLOC(logInVC);
        [self presentViewController:vc animated:YES completion:nil];

    }else{
        ALLOC(AskVC);
        vc.productId = self.productId;
        [self presentViewController:vc animated:YES completion:nil];

    }

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)getTheNoNullStr:(id)str andRepalceStr:(NSString*)replace{
    NSString *string=nil;
    if (![str isKindOfClass:[NSNull class]]) {
        string =  [NSString stringWithFormat:@"%@",str];

        if (string.length ==0||(NSNull*)string == [NSNull null]||[string isEqualToString:@"(null)"]) {
            string =replace;
        }
    }else{
        string =replace;
    }
    return string;
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
