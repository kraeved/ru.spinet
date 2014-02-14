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
    
    self.SendButtonView.layer.masksToBounds=YES;
    self.SendButtonView.layer.cornerRadius = 10.0;
    self.SendButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.SendButtonView.layer.borderWidth = 0.0;

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

- (IBAction)SendButtonClick:(id)sender {
    
    if([self validEmail:self.MailText.text]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=getnewpass&email=%@", self.MailText.text];
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString* session = cookie[@"session"];
            NSString *result = cookie[@"result"];
            //if(result.boolValue)
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MeetToday" message:@"Вам на почту выслано письмо с новым паролем!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self presentViewController:viewController animated:NO completion:nil];
                
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

- (IBAction)KeyboardHide:(id)sender
{
    [self.MailText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
