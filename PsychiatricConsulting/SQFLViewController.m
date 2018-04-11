//
//  SQFLViewController.m
//  PsychiatricConsulting
//
//  Created by mac on 15-8-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "SQFLViewController.h"
#import "pubStoryVC.h"
#import "Modle.h"
#import "ShequViewController.h"
@interface SQFLViewController ()
{
    SCREEN_WIDTH_AND_HEIGHT
    NSArray*dataArray;
    UIView *whiteview;

    UIButton *markBtn;
    UILabel*name_L;

}
@end

@implementation SQFLViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    TOP_VIEW(@"分类")

    self.view.backgroundColor=RGB(234, 234, 234);

    NSLog(@"+++++++%@",self.navigationController.viewControllers);

    [self getdata];


}

-(void)getdata{


    //1.加载社区话题分类数据

    [requestData getData:APP_URLL complete:^(NSDictionary *dic) {

        NSMutableArray *array = [[NSMutableArray alloc]init];
        dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            Modle *modle = [[Modle alloc]init];

            modle.typeName = [dict objectForKey:@"typeName"];
            modle.typeBackground = [dict objectForKey:@"typeBackground"];
            modle.smallIcon=[dict objectForKey:@"smallIcon"];
            modle.typeOrder=[dict objectForKey:@"typeOrder"];
            modle.interactiveId=dict[@"interactiveId"];
            modle.Remarks=dict[@"Remarks"];
            [array addObject:modle];
            //            NSLog(@"-----array-- %@",modle.typeName);


        }
        self.modleArray =[NSArray arrayWithArray:array];


        CGFloat Hhh=0.0;
        if (self.modleArray.count%3!=0) {
            Hhh= _width/4*(self.modleArray.count/3+1)+20;
        }else{
            Hhh= _width/4*(self.modleArray.count/3)+20;
        }


        whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 74, _width, Hhh+10)];
        whiteview.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:whiteview];
        
        [self initbutton];

        
        
    }];
    
    
    
}

-(void)initbutton{



        for (int i=0; i<self.modleArray.count; i++) {
            int  X=i%3;
            int y= i/3;
            Modle *modle = self.modleArray[i];

            UIButton*shopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            shopBtn.frame=CGRectMake(_width/3*X, y *(_width/4+10), _width/3-1, _width/4-1+10);
            [whiteview addSubview:shopBtn];
            shopBtn.backgroundColor = [UIColor whiteColor];
            shopBtn.tag=i;
            [shopBtn addTarget:self action:@selector(selectbutton:) forControlEvents:UIControlEventTouchUpInside];

            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake((_width/3-_width*0.16)/2,10, _width*0.16, _width*0.16)];
            [imageview sd_setImageWithURL:modle.smallIcon placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];


            imageview.clipsToBounds=YES;
            [shopBtn addSubview:imageview];
            name_L=[[UILabel alloc]initWithFrame:CGRectMake(0,10+_width*0.16 , _width/3, _width*0.08+5)];
            name_L.text=modle.typeName;
            name_L.textAlignment=NSTextAlignmentCenter;
            name_L.textColor=[UIColor blackColor];
            name_L.numberOfLines=0;
            name_L.font=[UIFont systemFontOfSize:13];
            [shopBtn addSubview:name_L];

            UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/4*(i+1),10, 1, 30)];
            shuxian.backgroundColor=RGB(234, 234, 234);


        }
   


}


-(void)selectbutton:(UIButton*)button{

    NSLog(@"+++++++%@",self.navigationController.viewControllers);
    for (UIViewController *viewVC in self.navigationController.viewControllers) {
        if ([viewVC isKindOfClass:[pubStoryVC class]]) {

            pubStoryVC *pushVC = (pubStoryVC*)viewVC;
            pushVC.classlab = [_modleArray[button.tag] typeName];
            pushVC.interactiveId =[_modleArray[button.tag] interactiveId];

            [self.navigationController popToViewController:pushVC animated:YES];

        }
    }
//    [self.navigationController pushViewController:pushVC animated:YES];
    NSLog(@"------%d",(int)button.tag);


    [self removeFromParentViewController];

}
-(void)backClick{
    POP
    NSLog(@"back");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
