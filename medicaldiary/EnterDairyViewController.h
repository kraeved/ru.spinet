//
//  EnterDairyViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterDairyViewController : UIViewController<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;

@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;
@end
