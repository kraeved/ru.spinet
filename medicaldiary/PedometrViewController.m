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
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    self.BottomView.delegate = self;
	// Do any additional setup after loading the view.
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:3]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
