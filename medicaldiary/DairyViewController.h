//
//  DairyViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 03.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Draw2D.h"

@interface DairyViewController : UIViewController<UITabBarDelegate>
{
    UITextField *StartDateEdit1;
}

+ (void)AddFactors: (NSDictionary*)factors;
@property (weak, nonatomic) IBOutlet UIImageView *Grafik;
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@property (weak, nonatomic) IBOutlet Draw2D *GrafView;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;
@property (weak, nonatomic) IBOutlet UIButton *AddFactor;
@property (weak, nonatomic) IBOutlet UIButton *ChangeFactor;
@property (weak, nonatomic) IBOutlet UIView *AddFactorView;
@property (weak, nonatomic) IBOutlet UIView *ChangeFactorView;
@property (weak, nonatomic) IBOutlet UIView *MyView;
@property (weak, nonatomic) IBOutlet UIButton *StartDateButton;
@property (weak, nonatomic) IBOutlet UIButton *EndDateButton;
@property (nonatomic, weak) IBOutlet UITextField *StartDateEdit;
@property (nonatomic,strong) UITextField *StartDateEdit1;
@property (weak, nonatomic) IBOutlet UITextField *EndDateEdit;
@property (weak, nonatomic) IBOutlet UIView *InstrView;
@property (weak, nonatomic) IBOutlet UIView *InstrViewBack;
@property (weak, nonatomic) IBOutlet UIButton *InstrButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *InstrConstraint;


@end
