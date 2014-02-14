//
//  OprosViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 04.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OprosViewController : UIViewController<UITabBarDelegate>
{
    NSInteger profile;
}

@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@property (weak, nonatomic) IBOutlet UIButton *sendotvet;
@property (weak, nonatomic) IBOutlet UIView *sendotvetview;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (nonatomic) NSInteger profile;

@end
