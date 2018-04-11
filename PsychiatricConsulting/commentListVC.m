//
//  commentListVC.m
//  logRegister
//
//  Created by apple on 15-1-22.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "commentListVC.h"

#import "comentListCell.h"
@interface commentListVC ()

@end

@implementation commentListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
  


    TOP_VIEW(@"评价列表")
    LOADVIEW

    NSLog(@"------%@",COMMENT_LIST_URL(self.productId, 1));
    [requestData getData:COMMENT_LIST_URL(self.productId, 1) complete:^(NSDictionary *dic) {
//        NSLog(@"%@",dic);
        LOADREMOVE
        _commentArray=[dic objectForKey:@"data"];
        [_tableview reloadData];
        if (_commentArray.count==0) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableview addSubview:tanhao];

            tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有好评哦！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableview addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
        }
    }];



    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    [self.view addSubview:_scrollView ];


    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, _width, _height-64-40) style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    //_tableview.rowHeight=130;
    _tableview.separatorColor=[UIColor clearColor];
    _tableview.dataSource=self;

    [_scrollView addSubview:_tableview];

    _moveView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, _width/3, 1)];
    _moveView.backgroundColor=APP_ClOUR;
    [_scrollView addSubview:_moveView];


    NSArray*array=[NSArray arrayWithObjects:@"好评",@"较好",@"一般", nil];
    for (int i=0; i<3; i++) {
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*_width/3, 0, _width/3, 40);
        [btn addTarget:self action:@selector(ThreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
        [btn setTitleColor:APP_ClOUR forState:UIControlStateSelected];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        btn.tag=i;
        if (btn.tag==0) {
            btn.selected=YES;
            _lastBtn=btn;
        }
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [_scrollView addSubview:btn];
    }
  //GRAY_TIAO(gray1, grayview, gray11, 40)

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return _commentArray.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    comentListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[comentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary*dic=[_commentArray objectAtIndex:indexPath.section];
    id face=[dic objectForKey:@"face"];
    id content=[dic objectForKey:@"content"];
    id replyConment=[dic objectForKey:@"replyConment"];
    id replyTime=[dic objectForKey:@"replyTime"];
    id skuName=[dic objectForKey:@"skuName"];
    id nickName=[dic objectForKey:@"nickName"];
    if (face==[NSNull null]) {
        face=nil;
    }

    if (replyConment==[NSNull null] || [NSString stringWithFormat:@"%@",replyConment].length ==0) {
        replyConment=@"还有没有评论内容哦！";
    }
    if (replyTime==[NSNull null]) {
        replyTime=@"";
    }
    if (skuName==[NSNull null]) {
        skuName=@"";
    }
    cell.commentSku.text=skuName;

      NSString*userid=[dic objectForKey:@"userId"];

   [cell.userface sd_setImageWithURL:[NSURL URLWithString:face] placeholderImage:[UIImage imageNamed:@"fang"]];
    if (nickName==[NSNull null]) {
        cell.username.text=[NSString stringWithFormat:@"%@****%@",[userid substringToIndex:3],[userid substringFromIndex:7]];

    }else
    {
        cell.username.text=nickName;
    }

    //cell.comment.text=[NSString stringWithFormat:@"评论：%@",replyConment];

    NSString*commentStr=[NSString stringWithFormat:@"%@",replyConment];
    CGSize size1=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:commentStr WithFont:[UIFont systemFontOfSize:12]];
    cell.commentView.frame=CGRectMake(0, 40, _width, size1.height+20);
//    NSLog(@"%f",size1.height);
    cell.comment.text=commentStr;
    cell.comment.frame=CGRectMake(_width*0.05, 0, _width*0.9, size1.height+15);
    cell.commentDate.frame=CGRectMake(_width*0.4, size1.height+10, _width*0.5,15);
    cell.userGrade.text=[dic objectForKey:@"exp"];

    id skuname=[dic objectForKey:@"skuName"];
    if (skuname==[NSNull null]) {
        skuname=@"";
    }
    cell.commentSku.text=skuname;
    cell.commentSku.frame=CGRectMake(0, size1.height+10, _width*0.5,15);


    cell.commentDate.text=[dic objectForKey:@"pubDate"];


    if (content==[NSNull null]) {
        content=@"";
        NSString*replayStr=[NSString stringWithFormat:@"%@",content];
        cell.replayView.frame=CGRectMake(0, 40+size1.height+20, _width,20);
        cell.replay.text=replayStr;
       // NSLog(@"jjjjjjjjj");
    }else
    {
         NSString*replayStr=[NSString stringWithFormat:@"回复：%@",content];
        CGSize size2=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:replayStr WithFont:[UIFont systemFontOfSize:12]];
        cell.replayView.frame=CGRectMake(0, 40+size1.height+30, _width, size2.height+20);
        cell.replayView.backgroundColor=RGB(244, 244, 244);
        cell.replay.text=replayStr;
        cell.replay.textColor=[UIColor grayColor];

        cell.replayDate.text=replyTime;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_commentArray objectAtIndex:indexPath.section];
    id face=[dic objectForKey:@"face"];
    id content=[dic objectForKey:@"content"];
    id replyConment=[dic objectForKey:@"replyConment"];
    id replyTime=[dic objectForKey:@"replyTime"];
    id skuName=[dic objectForKey:@"skuName"];
    if (face==[NSNull null]) {
        face=nil;
    }
//    if (content==[NSNull null]) {
//        content=@"(暂无回复)";
//    }
    if (replyConment==[NSNull null]) {
        replyConment=@"";
    }
    if (replyTime==[NSNull null]) {
      //  replyTime=@"";
    }
    if (skuName==[NSNull null]) {
       // skuName=@"";
    }



    //cell.comment.text=[NSString stringWithFormat:@"评论：%@",replyConment];

    NSString*commentStr=[NSString stringWithFormat:@"%@",replyConment];
    CGSize size1=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:commentStr WithFont:[UIFont systemFontOfSize:12]];


    float h2;

    if (content==[NSNull null]||content==nil) {
       // content=@"(暂无回复)";
        //NSString*replayStr=[NSString stringWithFormat:@"：%@",content];
        h2=20;

    }else
    {
        NSString*replayStr=[NSString stringWithFormat:@"回复：%@",content];
        CGSize size2=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:replayStr WithFont:[UIFont systemFontOfSize:12]];
        h2=size2.height+40;

    }
    //cell.replay.text=[NSString stringWithFormat:@"回复：%@",content];

    return 40+size1.height+h2+20;


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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary*dic=[_commentArray objectAtIndex:indexPath.row];
//    NSString*content=[dic objectForKey:@"content"];
//    NSString*replayComent=[dic objectForKey:@"replyConment"];
//    //NSFontAttributeName*text=[NSFontAttributeName a]
//    CGSize size=[replayComent sizeWithAttributes:@{replayComent:[UIFont systemFontOfSize:15]}];
//
//}
-(void)ThreeBtnClick:(UIButton*)button
{

    UIImageView*iv=(UIImageView*)[_tableview viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableview viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];


    
//    NSLog(@"%@",COMMENT_LIST_URL(self.productId, button.tag+1));
    [requestData getData:COMMENT_LIST_URL(self.productId, (int)(button.tag+1)) complete:^(NSDictionary *dic) {
//        NSLog(@"%@",dic);
        _commentArray=[dic objectForKey:@"data"];
        [_tableview reloadData];

        if (_commentArray.count==0) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableview addSubview:tanhao];




            tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有评价哦！";

//            if(button.tag==0)
//            {
//                tishi.text=@"没有好评哦！";
//
//            }
//            if(button.tag==1)
//            {
//                tishi.text=@"没有中评哦！";
//
//            }
//            if(button.tag==2)
//            {
//                tishi.text=@"没有差评哦！";
//                
//            }
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableview addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
        }
    }];
    if (button==_lastBtn) {

    }else
    {
        _lastBtn.selected=NO;
        button.selected=YES;
        _lastBtn=button;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.3];
        _moveView.frame=CGRectMake(_width/3*button.tag, 39, _width/3, 1);
        [UIView commitAnimations];
    }

}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
