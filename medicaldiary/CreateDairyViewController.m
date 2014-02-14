//
//  CreateDairyViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "CreateDairyViewController.h"
#import "Functions.h"

@interface CreateDairyViewController ()

@end

@implementation CreateDairyViewController

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
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
