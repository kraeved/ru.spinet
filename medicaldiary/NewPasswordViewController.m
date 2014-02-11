//
//  NewPasswordViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "Functions.h"

@interface NewPasswordViewController ()

@end

@implementation NewPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
	// Do any additional setup after loading the view.
    self.Label1.numberOfLines = 0;
    
    self.SendButton.layer.masksToBounds=YES;
    self.SendButton.layer.cornerRadius = 10.0;
    self.SendButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.SendButton.layer.borderWidth = 3.0;
    
    self.MailText.layer.masksToBounds=YES;
    self.MailText.layer.cornerRadius = 6.0;
    self.MailText.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.MailText.layer.borderWidth = 1.0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
