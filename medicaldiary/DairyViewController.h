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
+ (void)AddFactors: (NSDictionary*)factors;
@property (weak, nonatomic) IBOutlet UIImageView *Grafik;
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@property (weak, nonatomic) IBOutlet Draw2D *GrafView;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;
@property (weak, nonatomic) IBOutlet UIButton *AddFactor;
@property (weak, nonatomic) IBOutlet UIButton *ChangeFactor;
@property (weak, nonatomic) IBOutlet UIView *AddFactorView;
@property (weak, nonatomic) IBOutlet UIView *ChangeFactorView;

@end
