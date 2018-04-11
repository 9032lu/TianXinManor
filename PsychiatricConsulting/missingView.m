//
//  missingView.m
//  PsychiatricConsulting
//
//  Created by apple on 15-5-7.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "missingView.h"

@implementation missingView


- (void)drawRect:(CGRect)rect {


    _label=[[UILabel alloc]init];
    _label.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.6];
    _label.text=self.tishi;
    _label.textColor=[UIColor colorWithWhite:1 alpha:1];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.numberOfLines=0;
       _label.layer.cornerRadius=10;
    _label.clipsToBounds=YES;

//    if (self.labelFrame ==nil) {
        _label.frame=CGRectMake(self.frame.size.width/5, self.frame.size.height*0.8, self.frame.size.width*0.6, 50);
        if (self.tishi.length>10) {
            _label.frame=CGRectMake(self.frame.size.width/10, self.frame.size.height*0.8, self.frame.size.width*0.8, 50);
        }
//
//    }else{
//        _label.frame = *(self.labelFrame);
//    }
       [self addSubview:_label];

   

    [self performSelector:@selector(yanshi) withObject:nil afterDelay:2.2];
     
}
-(void)yanshi
{
    if (self.superview==nil) {

    }else
    {
        [UIView animateWithDuration:1 animations:^{
            _label.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];

       
    }

}


@end
