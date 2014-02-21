//
//  DairyViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 03.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Draw2D.h"
#import "FPPopoverController.h"
#import "PopoverViewController.h"

@class DairyViewController;



@interface DairyViewController : UIViewController<UITabBarDelegate,Draw2DDelegate,FPPopoverControllerDelegate,PopoverViewControllerDelegate>
{
    IBOutlet UITextField *StartDateEdit;
}


@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@property (weak, nonatomic) IBOutlet UIView *InstrView;
@property (weak, nonatomic) IBOutlet UIView *InstrViewBack;
@property (weak, nonatomic) IBOutlet UIButton *InstrButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *InstrConstraint;
//@property (strong, nonatomic) IBOutlet UILabel *Label1;
//- (void) DelegateFun:(NSDictionary*)data;

@end
