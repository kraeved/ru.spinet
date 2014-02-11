//
//  ResultOprosViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "ResultOprosViewController.h"
#import "Functions.h"

@interface ResultOprosViewController ()

@end

@implementation ResultOprosViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
