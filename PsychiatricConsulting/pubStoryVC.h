//
//  pubStoryVC.h
//  logRegister
//
//  Created by apple on 15-1-29.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "QBImagePickerController.h"
#import "myView.h"
@interface pubStoryVC : UIViewController<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,QBImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    UICollectionView    *_collectionView;
    UICollectionViewFlowLayout*_flowLayout;

    UITextView      *_contentText;
    UITextField *titletext;

    UITextField     *_placeholderLabel;
    int             _selectType;
    int             _imageSize;
    NSMutableArray  *_imageArray;
    UIImage         *_image;

    UILabel         *_number_L;
    UIButton        *_finishBtn;
    UILabel *Rlab;
    NSArray*dataArray;

    UIAlertView     *_alert;
    UILabel         *_denglu;
    myView          *_myView;


    QBImagePickerController*QBvc;

}

@property(nonatomic,copy)NSString*whoPush;

@property(nonatomic,copy)NSString*classlab;
@property(nonatomic,strong)NSArray *modleArray;
@property(nonatomic,copy)NSString *interactiveId;

@end
