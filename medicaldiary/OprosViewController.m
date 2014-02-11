//
//  OprosViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 04.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "OprosViewController.h"
#import "AppDelegate.h"
#import "Functions.h"

@interface OprosViewController ()

@end

@implementation OprosViewController

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
    if(item.tag==3)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"PedometrViewController"];
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:viewController animated:NO completion:nil];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
	// Do any additional setup after loading the view.
    [super viewDidLoad];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.BottomView.delegate = self;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:2]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
