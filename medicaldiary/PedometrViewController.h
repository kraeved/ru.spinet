//
//  PedometrViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PedometrViewController : UIViewController<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@property (weak, nonatomic) IBOutlet UILabel *PedoTime;
@property (weak, nonatomic) IBOutlet UILabel *speedlabel;
@property (weak, nonatomic) IBOutlet UILabel *callabel;
@property (weak, nonatomic) IBOutlet UILabel *distlabel;
@property (weak, nonatomic) IBOutlet UILabel *steplabel;
@property (weak, nonatomic) IBOutlet UIButton *startbutton;
@property (weak, nonatomic) IBOutlet UIView *startbuttonview;
@property (weak, nonatomic) IBOutlet UIButton *stopbutton;
@property (weak, nonatomic) IBOutlet UIView *stopbuttonview;
@property (weak, nonatomic) IBOutlet UIButton *resetbutton;
@property (weak, nonatomic) IBOutlet UIView *resetbuttonview;

@end
