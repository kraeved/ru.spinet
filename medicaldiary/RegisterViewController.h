//
//  RegisterViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *RegButton;
@property (weak, nonatomic) IBOutlet UITextField *LoginText;
@property (weak, nonatomic) IBOutlet UITextField *PassText;
@property (weak, nonatomic) IBOutlet UITextField *MailText;

@end
