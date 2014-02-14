//
//  MenuViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 13.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "MenuViewController.h"
#import "Functions.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    if(item.tag==2)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"OprosViewController"];
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
	// Do any additional setup after loading the view.
    
    [Functions MyGradient:self.view];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:0]];
    
    self.ExitButton.layer.masksToBounds=YES;
    self.ExitButton.layer.cornerRadius = 10.0;
    self.ExitButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.ExitButton.layer.borderWidth = 3.0;
    
    self.ExitButtonView.layer.masksToBounds=YES;
    self.ExitButtonView.layer.cornerRadius = 10.0;
    self.ExitButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.ExitButtonView.layer.borderWidth = 0.0;
    
    self.SiteButton.layer.masksToBounds=YES;
    self.SiteButton.layer.cornerRadius = 10.0;
    self.SiteButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.SiteButton.layer.borderWidth = 3.0;
    
    self.SiteButtonView.layer.masksToBounds=YES;
    self.SiteButtonView.layer.cornerRadius = 10.0;
    self.SiteButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.SiteButtonView.layer.borderWidth = 0.0;
    
    self.ForumButton.layer.masksToBounds=YES;
    self.ForumButton.layer.cornerRadius = 10.0;
    self.ForumButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.ForumButton.layer.borderWidth = 3.0;
    
    self.ForumButtonView.layer.masksToBounds=YES;
    self.ForumButtonView.layer.cornerRadius = 10.0;
    self.ForumButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.ForumButtonView.layer.borderWidth = 0.0;
    
    self.StatButton.layer.masksToBounds=YES;
    self.StatButton.layer.cornerRadius = 10.0;
    self.StatButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.StatButton.layer.borderWidth = 3.0;
    
    self.StatButtonView.layer.masksToBounds=YES;
    self.StatButtonView.layer.cornerRadius = 10.0;
    self.StatButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.StatButtonView.layer.borderWidth = 0.0;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    self.BottomView.delegate = self;
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];

}

- (IBAction)SiteButtonClick:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://spinet.ru"]];
}

- (IBAction)ForumButtonClick:(id)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://spinet.ru/conference/"]];
}

- (IBAction)StatButtonClick:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://spinet.ru/conference/"]];
}

- (IBAction)ExitButtonClick:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=logout&session=%@", session];
        
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@"" forKey:@"session"];
                [userDefaults synchronize];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self presentViewController:viewController animated:NO completion:nil];
            }
        }
        else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
