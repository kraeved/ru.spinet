//
//  AddFactorViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 10.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFactorViewController : UIViewController<UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIButton *AddFactor;
@property (weak, nonatomic) IBOutlet UIButton *SaveFactor;
@property (weak, nonatomic) IBOutlet UIButton *CreateFactors;
@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *SaveFactorView;
@property (weak, nonatomic) IBOutlet UIView *AddFactorView;
@property (weak, nonatomic) IBOutlet UIView *CreateFactorsView;
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;



@end
