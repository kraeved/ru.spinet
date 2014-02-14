//
//  PedometrViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "PedometrViewController.h"
#import "AppDelegate.h"
#import "Functions.h"

@interface PedometrViewController ()

@end

@implementation PedometrViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item.tag==0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
    if(item.tag==1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DairyViewController"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
    if(item.tag==2)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"OprosViewController"];
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:viewController animated:NO completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
    
    [self.speedlabel setFont:[UIFont fontWithName:@"Pocket Calculator" size:20.0f]];
    [self.callabel setFont:[UIFont fontWithName:@"Pocket Calculator" size:20.0f]];
    [self.distlabel setFont:[UIFont fontWithName:@"Pocket Calculator" size:20.0f]];
    [self.PedoTime setFont:[UIFont fontWithName:@"Pocket Calculator" size:60.0f]];
    [self.steplabel setFont:[UIFont fontWithName:@"Pocket Calculator" size:60.0f]];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    self.BottomView.delegate = self;
	// Do any additional setup after loading the view.
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:3]];
    
    self.startbutton.layer.masksToBounds=YES;
    self.startbutton.layer.cornerRadius = 10.0;
    self.startbutton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.startbutton.layer.borderWidth = 3.0;
    
    self.startbuttonview.layer.masksToBounds=YES;
    self.startbuttonview.layer.cornerRadius = 10.0;
    self.startbuttonview.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.startbuttonview.layer.borderWidth = 0.0;

    self.stopbutton.layer.masksToBounds=YES;
    self.stopbutton.layer.cornerRadius = 10.0;
    self.stopbutton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.stopbutton.layer.borderWidth = 3.0;
    
    self.stopbuttonview.layer.masksToBounds=YES;
    self.stopbuttonview.layer.cornerRadius = 10.0;
    self.stopbuttonview.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.stopbuttonview.layer.borderWidth = 0.0;

    self.resetbutton.layer.masksToBounds=YES;
    self.resetbutton.layer.cornerRadius = 10.0;
    self.resetbutton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.resetbutton.layer.borderWidth = 3.0;
    
    self.resetbuttonview.layer.masksToBounds=YES;
    self.resetbuttonview.layer.cornerRadius = 10.0;
    self.resetbuttonview.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.resetbuttonview.layer.borderWidth = 0.0;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
