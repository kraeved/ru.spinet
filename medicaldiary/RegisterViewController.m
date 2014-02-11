//
//  RegisterViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "RegisterViewController.h"
#import "Functions.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 Функция валидации почтового адреса
 */
-(BOOL) validEmail:(NSString*) emailString {
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    //NSLog(@"%i", regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
	// Do any additional setup after loading the view.
    
    self.RegButton.layer.masksToBounds=YES;
    self.RegButton.layer.cornerRadius = 10.0;
    self.RegButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.RegButton.layer.borderWidth = 3.0;
    
    self.LoginText.layer.masksToBounds=YES;
    self.LoginText.layer.cornerRadius = 6.0;
    self.LoginText.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.LoginText.layer.borderWidth = 1.0;
    
    self.PassText.layer.masksToBounds=YES;
    self.PassText.layer.cornerRadius = 6.0;
    self.PassText.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.PassText.layer.borderWidth = 1.0;

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

- (IBAction)RegisterButton:(id)sender {
    
    if([self validEmail:self.MailText.text] && self.PassText.text.length>0 && self.LoginText.text.length>0) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        ///api/register?email=vorobyev.stanislav@yandex.ru&password=s1234&password2=s1234&year=1981&month=11&day=10&name=stanislav&sex=male
        NSString *myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=registration&email=%@&pass=%@&login=%@",self.MailText.text, self.PassText.text,self.LoginText.text];
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        NSLog(@"cookie: %@",cookie);
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            if(result.boolValue)
            {
                //Email Address is not Valid
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MeetToday" message:@"Вы успешно зарегистрировались!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self presentViewController:viewController animated:NO completion:nil];
            }
            else
            {
                NSString *error = cookie[@"error"];
                if([error isEqualToString:@"bademail"])
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MeetToday" message:@"Пользователь с таким почтовым адресом существует!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    
                }
                else if([error isEqualToString:@"badlogin"])
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MeetToday" message:@"Пользователь с таким именем существует!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            }
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MeetToday" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    } else {
        //Email Address is not Valid
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MeetToday" message:@"Некорректный ввод данных!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

@end
