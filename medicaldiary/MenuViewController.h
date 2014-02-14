//
//  MenuViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 13.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@property (weak, nonatomic) IBOutlet UIButton *ExitButton;
@property (weak, nonatomic) IBOutlet UIView *ExitButtonView;
@property (weak, nonatomic) IBOutlet UIButton *SiteButton;
@property (weak, nonatomic) IBOutlet UIView *SiteButtonView;
@property (weak, nonatomic) IBOutlet UIButton *ForumButton;
@property (weak, nonatomic) IBOutlet UIView *ForumButtonView;
@property (weak, nonatomic) IBOutlet UIButton *StatButton;
@property (weak, nonatomic) IBOutlet UIView *StatButtonView;

@end
