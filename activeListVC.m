
//
//  activeListVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "activeListVC.h"
#import "transformTime.h"
#import "myOrderDetailVC.h"
@interface activeListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView             *_tableView;

    NSMutableArray *_dataArray;
}
@end

@implementation activeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"活动列表")
    _dataArray = [[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];

    [self getData];

}
-(void)getData
{


    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

    NSString *url = [NSString stringWithFormat:@"%@/activity/activityList.action",BASE_URLL];
    [requestData  getData:url complete:^(NSDictionary *dic) {
        NSLog(@"dic======%@",url);
        NSMutableArray *endArray = [[NSMutableArray alloc]init];
        NSArray *array = [dic objectForKey:@"data"];

        for (int i = 0; i <array.count; i++) {
            NSDictionary *ddit = array[i];
            if ([ddit[@"IsEnd"] integerValue]==0) {
                [_dataArray addObject:ddit];
            }else{
                [endArray addObject:ddit];
            }
        }

        [_dataArray addObjectsFromArray:endArray];

        NSLog(@"array======%@",endArray);


        if (_dataArray.count==0||_dataArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有预约!";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;

        }
        
        [_tableView reloadData];
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return _width*0.45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
   NSDictionary *_dataDict =_dataArray[indexPath.row];
    UIImageView *iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, _width-10, _width*0.45-10)];
//    iamgeview.backgroundColor =[UIColor redColor];
    iamgeview.clipsToBounds= YES;
    [iamgeview sd_setImageWithURL:[NSURL URLWithString:_dataDict[@"activityImage"]] placeholderImage:[UIImage imageNamed:@"0826_8.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image==nil) {
            image=[UIImage imageNamed:@"0826_8.jpg"];
        }
        //                    float  H=_width*image.size.height/image.size.width;
////
//        float   w=image.size.width;
//        float   hh=image.size.height;
//        if (hh>w) {
//            float  W=(_width*0.55-10)*image.size.width/image.size.height;
//
//
//            iamgeview.frame=CGRectMake((_width-10-W)/2+5, 0, W, _width*0.55-10);
//
//
//        }else
//        {
//            float  H=(_width*0.55-10)*image.size.height/image.size.width;
//             iamgeview.frame=CGRectMake(5, (_width*0.55-10-H)/2, _width-10, _width*0.55-10);
////
//
//        }

        

    }];
    iamgeview.layer.cornerRadius = 5;
    [cell.contentView addSubview:iamgeview];

    UIImageView *endImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width*0.156, _width*0.156)];
    [iamgeview addSubview:endImage];

    if ([_dataDict[@"IsEnd"]integerValue]==1) {
        endImage.image = [UIImage imageNamed:@"theend"];
    }

    if ([_dataDict[@"IsEnd"]integerValue]==0){
        endImage.image = [UIImage imageNamed:@"jinxingzhong"];
    }

    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(5, _width*0.3,_width-10,  _width*0.15-5)];

    view.backgroundColor = [UIColor blackColor];
    view.alpha=0.7;
    [cell.contentView addSubview:view];

    UILabel*activityTitle=[[UILabel alloc]init];
      activityTitle.text=_dataDict[@"activityTitle"];
        activityTitle.numberOfLines=0;
        activityTitle.textAlignment=NSTextAlignmentLeft;
        activityTitle.textColor=[UIColor whiteColor];
        activityTitle.font=[UIFont boldSystemFontOfSize:20];
        [cell.contentView addSubview:activityTitle];
    
    
//    UILabel*startDate=[[UILabel alloc]init];
//        startDate.text = [NSString stringWithFormat:@"开始时间：%@",[transformTime transformtime:_dataDict[@"startDate"]]] ;
//        startDate.numberOfLines=1;
//        startDate.textAlignment=NSTextAlignmentLeft;
//        startDate.textColor=[UIColor whiteColor];
//        startDate.font=[UIFont systemFontOfSize:13];
//        [cell.contentView addSubview:startDate];
//

//    NSString *startString =[transformTime transformtime:_dataDict[@"startDate"]];
//    NSString *endString =[transformTime transformtime:_dataDict[@"endDate"]];

//        UILabel*endDate=[[UILabel alloc]init];
//        endDate.text= [NSString stringWithFormat:@"(活动时间：%@—%@)",startString,endString];
//        endDate.numberOfLines=0;
//        endDate.textAlignment=NSTextAlignmentLeft;
//        endDate.textColor=[UIColor whiteColor];
//        endDate.font=[UIFont systemFontOfSize:13];
//        [cell.contentView addSubview:endDate];
//
//     NSString *string= [activityTitle.text stringByAppendingString:endDate.text];
//
//
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
//
//    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, activityTitle.text.length+1)];
//    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(activityTitle.text.length+1, endDate.text.length)];
//    activityTitle.attributedText = str;




//举办地点
//        UILabel*activityAddress=[[UILabel alloc]init];
//        activityAddress.text= [NSString stringWithFormat:@"举办地点：%@",_dataDict[@"activityAddress"]] ;
//        activityAddress.numberOfLines=1;
//        activityAddress.textAlignment=NSTextAlignmentLeft;
//        activityAddress.textColor=[UIColor whiteColor];
//        activityAddress.font=[UIFont systemFontOfSize:13];
//        [cell.contentView addSubview:activityAddress];

//
//    if (indexPath.row ==0) {
//        iamgeview.image =[UIImage imageNamed:@"活动1"];
//        activityTitle.frame= CGRectMake(_width*0.5, _width*0.05, _width*0.4, _width*0.1);
//        startDate.frame = CGRectMake(_width*0.4, _width*0.3,_width*0.55, _width*0.05);
//        endDate.frame =CGRectMake(_width*0.4, _width*0.35, _width*0.55, _width*0.05);
//        activityAddress.frame = CGRectMake(_width*0.4, _width*0.4, _width*0.55, _width*0.05);
//    }else{
//        iamgeview.image =[UIImage imageNamed:@"0826_8.jpg"];


   CGSize size =[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:activityTitle.text WithFont:[UIFont boldSystemFontOfSize:20]];
    activityTitle.frame= CGRectMake(_width*0.05, _width*0.32, size.width, _width*0.1);

//    activityTitle.bounds = CGRectMake(0, 0, _width*0.8, _width*0.1);
//    activityTitle.center = CGPointMake(_width/2, _width*0.07);
//        startDate.frame = CGRectMake(_width*0.1, _width*0.3,_width*0.55, _width*0.05);


//        endDate.frame =CGRectMake(_width*0.05+size.width+10, _width*0.445, _width*0.55, _width*0.05);
//        activityAddress.frame = CGRectMake(_width*0.1, _width*0.4+5, _width*0.85, _width*0.05);
//
//    }
//




    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PUSH(myOrderDetailVC)
    vc.appointmentId = [_dataArray[indexPath.row] objectForKey:@"activityId"];
    vc.IsEnd =[[_dataArray[indexPath.row] objectForKey:@"IsEnd"]integerValue];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backClick{
    POP
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

@end
