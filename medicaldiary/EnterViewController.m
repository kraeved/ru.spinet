//
//  EnterViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "EnterViewController.h"
#import "Functions.h"

@interface EnterViewController ()

@end

@implementation EnterViewController

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
    
    self.EnterButton.layer.masksToBounds=YES;
    self.EnterButton.layer.cornerRadius = 10.0;
    self.EnterButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.EnterButton.layer.borderWidth = 3.0;
    
    self.EnterButtonView.layer.masksToBounds=YES;
    self.EnterButtonView.layer.cornerRadius = 10.0;
    self.EnterButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.EnterButtonView.layer.borderWidth = 0.0;
    
    self.RegButton.layer.masksToBounds=YES;
    self.RegButton.layer.cornerRadius = 10.0;
    self.RegButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.RegButton.layer.borderWidth = 3.0;
    
    self.RegButtonView.layer.masksToBounds=YES;
    self.RegButtonView.layer.cornerRadius = 10.0;
    self.RegButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.RegButtonView.layer.borderWidth = 0.0;
    
    self.LoginTextEdit.layer.masksToBounds=YES;
    self.LoginTextEdit.layer.cornerRadius = 6.0;
    self.LoginTextEdit.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.LoginTextEdit.layer.borderWidth = 1.0;
    
    self.PasswordtextEdit.layer.masksToBounds=YES;
    self.PasswordtextEdit.layer.cornerRadius = 6.0;
    self.PasswordtextEdit.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.PasswordtextEdit.layer.borderWidth = 1.0;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)KeyboardHide:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)viewTap:(id)sender
{
    [self.LoginTextEdit resignFirstResponder];
    [self.PasswordtextEdit resignFirstResponder];
}

- (IBAction)EnterButtonClick:(id)sender {
    //NSString *mydomain=@"localhost";
    if(self.LoginTextEdit.text.length>0 && self.PasswordtextEdit.text.length>0) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=login&login=%@&pass=%@", self.LoginTextEdit.text,self.PasswordtextEdit.text];
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString* session = cookie[@"session"];
            NSString *result = cookie[@"result"];
            if(result.boolValue)
            {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:session forKey:@"session"];
                [userDefaults synchronize];
                [UIView animateWithDuration:3.0 delay:2.0 options:0
                                 animations:^
                 {
                 }
                                 completion:^( BOOL completed )
                 {
                     // По окончанию анимации выполним наш переход к стартовому экрану
                     [self performSegueWithIdentifier:@"EnterToDairy" sender:self];
                     
                 }];
                
            }
            else {
                //Email Address is not Valid
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Spinet" message:@"Неправильная пара логина и пароля!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        else {
            //Email Address is not Valid
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Spinet" message:@"Ошибка соединения с сервером!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        
    } else {
        //Email Address is not Valid
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Spinet" message:@"Некорректный ввод данных!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

@end
