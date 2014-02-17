//
//  EnterDairyViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterDairyViewController : UIViewController<UITabBarDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;

@property (weak, nonatomic) IBOutlet UIButton *OkButton;
@property (weak, nonatomic) IBOutlet UIView *OkButtonView;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;
@property (weak, nonatomic) IBOutlet UITextView *CommentEdit;
@property (weak, nonatomic) IBOutlet UIView *CommentView;
@end
