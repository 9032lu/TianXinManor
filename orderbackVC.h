//
//  orderbackVC.h
//  PsychiatricConsulting
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "QBImagePickerController.h"
#import "myView.h"
@interface orderbackVC : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,QBImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *realPrice;
@property(nonatomic,copy)NSString *orderState;
@property(nonatomic,copy)NSString *productId;

@end
