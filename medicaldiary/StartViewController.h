//
//  StartViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
@property (strong, nonatomic) IBOutlet UIView *StartSplash;
@property (weak, nonatomic) IBOutlet UIImageView *LogoView;

@end
