//
//  PopoverViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 13.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@class PopoverViewController;
@protocol PopoverViewControllerDelegate <NSObject>
@required
- (void) ClosePopover;

@end

@interface PopoverViewController : UIViewController

@property (nonatomic,weak)  id <PopoverViewControllerDelegate> delegate;
-(int)ShowInfoTwo;
- (void)changeDate:(UIButton*)button;

@end
