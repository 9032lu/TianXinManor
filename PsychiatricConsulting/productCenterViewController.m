//
//  productCenterViewController.m
//  PsychiatricConsulting
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "productCenterViewController.h"

@interface productCenterViewController ()
{
    SCREEN_WIDTH_AND_HEIGHT

}


@end

@implementation productCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"商品分类")
    backBtn.hidden=NO;
    backTi.hidden=NO;

    _modleArray = [[NSMutableArray alloc]init];


    bigScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    bigScrol.delegate = self,
    bigScrol.contentSize= CGSizeMake(_width, _height-64);
    bigScrol.pagingEnabled =YES;
    [self.view addSubview:bigScrol];



    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _height-64)];
    UIImage *backgroundImage = [UIImage imageNamed:@"产品列表"];
    [backgroundImageView setImage:backgroundImage];
    [bigScrol addSubview:backgroundImageView];

    [self getdata];


}
-(void)creatTimeView{
    //时光轴的背景
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _scrollView.contentSize.height+50+50)];
    _imageView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_imageView];

    PlanLine *plan = [[PlanLine alloc]init];

    plan.delegate = self;
    //划线
    [plan setImageView:_imageView setlineWidth:2.0 setColorRed:108/255.0f ColorBlue:184/255.0f ColorGreen:155/255.0f Alp:1 setBeginPointX:60 BeginPointY:0 setOverPointX:60 OverPointY:_scrollView.contentSize.height-150];
}

-(void)makeScrollView:(NSUInteger)number
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height-64)];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, number*200);
    [bigScrol addSubview:_scrollView];
}

-(void)markYearsButton:(NSUInteger)number{

    for (NSInteger i = number-1, j = 0; i >=0; i--,j ++)
    {
        buttonArray = [[NSMutableArray alloc]init];

        yearbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        yearbutton.backgroundColor =[UIColor whiteColor];
        yearbutton.frame = CGRectMake(35, j*200+50, 50, 50);
        yearbutton.layer.cornerRadius =25;
        yearbutton.layer.borderWidth=2;
        yearbutton.layer.borderColor= [UIColor colorWithRed:108/255.0f green:184/255.0f blue:155/255.0f alpha:1.0f].CGColor;
        yearbutton.tag = [[_modleArray[i] categoryId] integerValue];
        [yearbutton setTitle:[_modleArray[i] categoryName] forState:UIControlStateNormal];
        [yearbutton setTitleColor:[UIColor colorWithRed:108/255.0f green:184/255.0f blue:155/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [yearbutton addTarget:self action:@selector(openMassage:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:yearbutton];
        [buttonArray addObject:yearbutton];


    }



}
//信息简介view
-(void)makeView:(NSUInteger)number
{

    for (NSInteger i = number-1,j =0; i >=0; i--,j++)
    {


        //设置背景
        self.massageView = [[UIImageView alloc]initWithFrame:CGRectMake(85, j*200+10, _width*0.65, 130)];
        _massageView.layer.cornerRadius=10;
//        _massageView.backgroundColor = [UIColor whiteColor];
        _massageView.image =[UIImage imageNamed:@"4(2)"];
        [_scrollView addSubview:_massageView];
//设置标题
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.13, 5, _width*0.5, 30)];
        _label.textAlignment= 0;
        NSString *str = [NSString stringWithFormat:@"%@年",[_modleArray[i] categoryName]];
        [_label setText:str];
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont boldSystemFontOfSize:15];
        _label.backgroundColor = [UIColor clearColor];
        [_massageView addSubview:_label];
        [_massageView setUserInteractionEnabled:YES];

        UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.13, 30, _width*0.5, 50)];
//        detail.backgroundColor =[UIColor redColor];
        detail.text =[_modleArray[i] ldescription];
        detail.numberOfLines=2;
        detail.textColor=[UIColor darkGrayColor];
        detail.font =[UIFont systemFontOfSize:13];
        [_massageView addSubview:detail];
//设置查看按钮
        myButton *scanBtn= [myButton buttonWithType:UIButtonTypeRoundedRect];
        scanBtn.frame = CGRectMake(_width*0.22, 130-45 ,_width*0.3, 35);
        scanBtn.backgroundColor =APP_ClOUR;
        [scanBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [scanBtn addTarget:self action:@selector(scandetail:) forControlEvents:UIControlEventTouchUpInside];
        [scanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [scanBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        scanBtn.layer.cornerRadius=5;


//        NSLog(@"-----%@",[_modleArray[i] categoryId]);

        scanBtn.tag=[[_modleArray[i] categoryId] integerValue];
        scanBtn.catagerid =[_modleArray[i] categoryName];
        [_massageView addSubview:scanBtn];

        [_massageView bringSubviewToFront:scanBtn];
    }
}
//时间按钮的点击事件
-(void)openMassage:(UIButton*)sender
{
    PUSH(classViewController)
    vc.categoryId =[NSString stringWithFormat:@"%ld",(long)sender.tag];
    vc.categoryName=sender.titleLabel.text;
    vc.whoPush =@"productCenter";

}

-(void)scandetail:(myButton*)sender{

    PUSH(classViewController)
    vc.categoryId =[NSString stringWithFormat:@"%ld",(long)sender.tag];
    vc.categoryName=sender.catagerid;
    vc.whoPush =@"productCenter";

}



-(void)backClick
{
    NSLog(@"back");
    POP

}

-(void)getdata{


    UIImageView*iv=(UIImageView*)[_scrollView viewWithTag:22222];
    UILabel*la=(UILabel*)[_scrollView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    NSString *url = [NSString stringWithFormat:@"%@/category/list.action",BASE_URLL];
    LOADVIEW

    [requestData getData:url complete:^(NSDictionary *dic) {
        LOADREMOVE
        dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            Modle *modle = [[Modle alloc]init];

            modle.categoryName = [dict objectForKey:@"categoryName"];
            modle.ldescription = [self getTheNoNullStr:[dict objectForKey:@"description"] andRepalceStr:@"暂无详情！"];
            modle.categoryId = [dict objectForKey:@"categoryId"];
            [_modleArray addObject:modle];
//            NSLog(@"modle==%@", modle.categoryId);


        }

//        NSLog(@"modle==%@",_modleArray);


        [self makeScrollView:_modleArray.count];

        [self creatTimeView];

        //时光轴上的时间按钮
        [self markYearsButton:_modleArray.count];
        
        [self makeView:_modleArray.count];
        

//        [self performSelectorOnMainThread:@selector(getDataList:)
//                               withObject:_modleArray // 将局部变量dataList作为参数传出去
//                            waitUntilDone:YES];

        if (_modleArray.count==0||_modleArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_scrollView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"暂无相关商品！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_scrollView addSubview:tishi];
            
            
        }



    }];
    
    
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
//-(void)getDataList:(id)sender {
//    NSMutableArray * dataList = (NSMutableArray *)sender;
//     _modleArray= dataList; // 保留原来的_dataList, 用在这里
//}


@end
