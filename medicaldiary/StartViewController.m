//
//  StartViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "StartViewController.h"
#import "Functions.h"

@interface StartViewController ()

@end

@implementation StartViewController

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
    UIImage *image = [UIImage imageNamed:@"logo"];
    [self.LogoView setImage:image];
    self.LogoView.layer.zPosition=1;
    self.Indicator.layer.zPosition=2;
	// Do any additional setup after loading the view.
    [self.Indicator startAnimating];
    int mode=0;
    //Functions.ti
    //Functions *funcs = [Functions alloc];
    //проверка наличия настроек
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    NSLog(@"%@",session);
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        //проверка наличия интернета
        //проверка валидности кук
        //NSString *mydomain=@"localhost";
         //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            //NSString *myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=valid&session=%@", session];
            NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=getnextopros&session=%@", session];
            NSDictionary* cookie = [Functions SendGetRequest:myurl];
            if(cookie)
            {
                NSString *result = cookie[@"result"];
                NSLog(@"result: %@", result);
                if(result.boolValue)
                {
                    NSArray* variants = [cookie objectForKey:@"variants"];
                    if(variants.count>0)
                        mode=2;
                    else
                        mode=1;
                }
                else {
                    mode=0;
                }
            }
            else mode=0;
   
        
    } else {
        NSLog(@"Unlogin");
        mode=0;
    }
    
	// Do any additional setup after loading the view.
    [UIView animateWithDuration:3.0 delay:2.0 options:0
                     animations:^
     {
         CGRect frame = self.StartSplash.frame; //self.imageView.frame;
         frame.origin.y = 15.0;
         self.StartSplash.frame = frame;
     }
                     completion:^( BOOL completed )
     {
         // По окончанию анимации выполним наш переход к стартовому экрану
         [self.Indicator stopAnimating];
         if (mode==1) {
             [self performSegueWithIdentifier:@"DairyViewController" sender:self];
         }
         else if(mode==2) {
             [self performSegueWithIdentifier:@"StartToOpros" sender:self];
         }
         else
         {
             [self performSegueWithIdentifier:@"EnterViewController" sender:self];
         }
         
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
