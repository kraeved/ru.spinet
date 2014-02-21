//
//  AddFactorViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 10.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "AddFactorViewController.h"
#import "Functions.h"
#import "AppDelegate.h"
#import "CustomScrollView.h"

@interface AddFactorViewController ()

@end

@implementation AddFactorViewController

NSMutableArray *dataArray;
NSMutableDictionary *mydata;

UIView *vi1,*vi2;
UIButton *button1,*button2;
CustomScrollView *mainScroll;
NSNumber *count;
int cc=0;

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
    cc=0;
	// Do any additional setup after loading the view.
    [Functions MyGradient:self.view];
    self.AddFactor.layer.masksToBounds=YES;
    self.AddFactor.layer.cornerRadius = 10.0;
    self.AddFactor.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.AddFactor.layer.borderWidth = 3.0;
    
    self.SaveFactor.layer.masksToBounds=YES;
    self.SaveFactor.layer.cornerRadius = 10.0;
    self.SaveFactor.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.SaveFactor.layer.borderWidth = 3.0;
    
    self.CreateFactors.layer.masksToBounds=YES;
    self.CreateFactors.layer.cornerRadius = 10.0;
    self.CreateFactors.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.CreateFactors.layer.borderWidth = 3.0;
    
    self.Label1.numberOfLines = 0;
    
    self.View1.layer.masksToBounds=YES;
    self.View1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.View1.layer.borderWidth = 1.0;
    
    self.CreateFactorsView.layer.masksToBounds=YES;
    self.CreateFactorsView.layer.cornerRadius = 10.0;
    self.CreateFactorsView.layer.borderWidth = 0.0;
    
    self.SaveFactorView.layer.masksToBounds=YES;
    self.SaveFactorView.layer.cornerRadius = 10.0;
    self.SaveFactorView.layer.borderWidth = 0.0;
    
    self.AddFactorView.layer.masksToBounds=YES;
    self.AddFactorView.layer.cornerRadius = 10.0;
    self.AddFactorView.layer.borderWidth = 0.0;

    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    self.View1.layer.zPosition=1;
    self.BottomView.layer.zPosition=1;
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    
    self.BottomView.delegate = self;
    
    //mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, mainScroll.contentSize.height+(((name.count%2) + name.count)*205/2));
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormat stringFromDate:date];
        
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=gettodaydata&session=%@&date=%@", session, dateString];
        NSLog(@"%@",myurl);
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                NSArray* legend = [cookie objectForKey:@"gettodaydata"];
                NSString *empty = [cookie objectForKey:@"empty"];
                count = [cookie objectForKey:@"count"];
                dataArray = [[NSMutableArray alloc] init];
                
                // Add some data for demo purposes.
                for(int i=1;i<11;i++) [dataArray addObject:[NSString stringWithFormat:@"%i", i]];
                /*if(0)//[empty intValue]==0)
                {
                    for (id key in [name allKeys]) {

                    }
                }
                else*/
                {
                    int i=0;
                    if([count intValue])
                    {
                        self.View1.hidden = YES;
                        
                        mainScroll = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.BottomView.frame.origin.y-70)];
                        
                        mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, [count intValue]*60+110);
                        mainScroll.layer.zPosition=0;
                        NSLog(@"%f",mainScroll.frame.size.height);
                        [self.view addSubview:mainScroll];
                        //mainScroll.backgroundColor = [Functions colorWithRGBHex:0xeaedf1];
                        //mainScroll.layer.zPosition=0;
                        mainScroll.pagingEnabled = YES;
                        mainScroll.scrollEnabled = YES;
                        [mainScroll setUserInteractionEnabled:YES];
                        //[self.view sendSubviewToBack:mainScroll];


                        for (i=0;i<[count intValue];i++)
                        {
                            UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(60, 20+i*60,self.view.frame.size.width-120,40)];
                            text1.layer.masksToBounds=YES;
                            text1.layer.cornerRadius = 5.0;
                            text1.text = [NSString stringWithFormat:@"%@", [legend[i] objectForKey:@"text"]];
                            text1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                            text1.backgroundColor = [UIColor whiteColor];
                            text1.layer.borderWidth = 1.0;
                            text1.font = [UIFont systemFontOfSize:10];
                            text1.userInteractionEnabled=YES;
                            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                            text1.leftView = paddingView;
                            text1.leftViewMode = UITextFieldViewModeAlways;
                            text1.textAlignment = NSTextAlignmentCenter;
                            [mainScroll addSubview:text1];
                            text1.tag = [[legend[i] objectForKey:@"tip"] intValue];
                            
                            //i++;
                            
                        }
                        
                        vi1 = [[UIView alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-162)/2, 20+i*60-1,162,38)];
                        vi1.layer.masksToBounds=YES;
                        vi1.layer.cornerRadius = 10.0;
                        vi1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi1.layer.borderWidth = 0.0;
                        vi1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [mainScroll addSubview:vi1];
                        
                        button1 = [[UIButton alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-162)/2+1, 20+i*60,160,36)];
                        button1.layer.masksToBounds=YES;
                        button1.layer.cornerRadius = 10.0;
                        button1.titleLabel.text = @"Добавить фактор";
                        [button1 setTitle:@"Добавить фактор" forState:UIControlStateNormal];
                        button1.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button1.layer.borderWidth = 3.0;
                        button1.titleLabel.font = [UIFont systemFontOfSize:13];
                        button1.tintColor = [UIColor whiteColor];
                        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [button1 addTarget:self action:@selector(addfactorfun:) forControlEvents:UIControlEventTouchUpInside];
                        button1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        button1.userInteractionEnabled=YES;
                        [mainScroll addSubview:button1];
                        
                        vi2 = [[UIView alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-124)/2, 20+i*60+50-1,124,50)];
                        vi2.layer.masksToBounds=YES;
                        vi2.layer.cornerRadius = 10.0;
                        vi2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi2.layer.borderWidth = 0.0;
                        vi2.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [mainScroll addSubview:vi2];
                        
                        button2 = [[UIButton alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-122)/2, 20+i*60+50,122,48)];
                        button2.layer.masksToBounds=YES;
                        button2.layer.cornerRadius = 10.0;
                        //button2.titleLabel.text = @"Сохранить";
                        [button2 setTitle:@"Сохранить" forState:UIControlStateNormal];
                        button2.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button2.layer.borderWidth = 3.0;
                        button2.titleLabel.font = [UIFont systemFontOfSize:20];
                        button2.tintColor = [UIColor whiteColor];
                        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [button2 addTarget:self action:@selector(senddata:) forControlEvents:UIControlEventTouchUpInside];
                        button2.backgroundColor = [Functions colorWithRGBHex:0x78aa45];
                        button2.userInteractionEnabled=YES;
                        [mainScroll addSubview:button2];

                    }
                    else
                    {

                        mainScroll = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 76, self.view.frame.size.width, self.BottomView.frame.origin.y-76-self.View1.frame.size.height)];
                        
                        mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, 320);

                        mainScroll.layer.zPosition=0;
                        NSLog(@"%f",mainScroll.frame.size.height);
                        [self.view addSubview:mainScroll];
                        //mainScroll.backgroundColor = [Functions colorWithRGBHex:0xeaedf1];
                        //mainScroll.layer.zPosition=0;
                        mainScroll.pagingEnabled = YES;
                        mainScroll.scrollEnabled = YES;
                        [mainScroll setUserInteractionEnabled:YES];
                        //[self.view sendSubviewToBack:mainScroll];
                        self.View1.hidden = NO;
                        
                        UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(60, 20,self.view.frame.size.width-120,40)];
                        text1.layer.masksToBounds=YES;
                        text1.layer.cornerRadius = 5.0;
                        text1.text = @"Качество массажа";
                        text1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                        text1.backgroundColor = [UIColor whiteColor];
                        text1.layer.borderWidth = 1.0;
                        text1.font = [UIFont systemFontOfSize:10];
                        text1.userInteractionEnabled=YES;
                        text1.textAlignment = NSTextAlignmentCenter;
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                        text1.leftView = paddingView;
                        text1.leftViewMode = UITextFieldViewModeAlways;
                        [mainScroll addSubview:text1];
                        
                        UITextField *text2 = [[UITextField alloc] initWithFrame:CGRectMake(60, 80,self.view.frame.size.width-120,40)];
                        text2.layer.masksToBounds=YES;
                        text2.layer.cornerRadius = 5.0;
                        text2.text = @"Выброс эндорфина";
                        text2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                        text2.backgroundColor = [UIColor whiteColor];
                        text2.layer.borderWidth = 1.0;
                        text2.textAlignment = NSTextAlignmentCenter;
                        text2.font = [UIFont systemFontOfSize:10];
                        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                        text2.userInteractionEnabled=YES;
                        text2.leftView = paddingView2;
                        text2.leftViewMode = UITextFieldViewModeAlways;
                        [mainScroll addSubview:text2];
                        
                        UITextField *text3 = [[UITextField alloc] initWithFrame:CGRectMake(60, 140,self.view.frame.size.width-120,40)];
                        text3.layer.masksToBounds=YES;
                        text3.layer.cornerRadius = 5.0;
                        text3.text = @"Головная боль";
                        text3.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                        text3.backgroundColor = [UIColor whiteColor];
                        text3.layer.borderWidth = 1.0;
                        text3.font = [UIFont systemFontOfSize:10];
                        text3.userInteractionEnabled=YES;
                        text3.textAlignment = NSTextAlignmentCenter;
                        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                        text3.leftView = paddingView3;
                        text3.leftViewMode = UITextFieldViewModeAlways;
                        [mainScroll addSubview:text3];
                        
                        
                        vi1 = [[UIView alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-162)/2, 199,162,38)];
                        vi1.layer.masksToBounds=YES;
                        vi1.layer.cornerRadius = 10.0;
                        vi1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi1.layer.borderWidth = 0.0;
                        vi1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [mainScroll addSubview:vi1];
                        
                        button1 = [[UIButton alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-162)/2+1, 200,160,36)];
                        button1.layer.masksToBounds=YES;
                        button1.layer.cornerRadius = 10.0;
                        button1.titleLabel.text = @"Добавить фактор";
                        [button1 setTitle:@"Добавить фактор" forState:UIControlStateNormal];
                        button1.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button1.layer.borderWidth = 3.0;
                        button1.titleLabel.font = [UIFont systemFontOfSize:13];
                        button1.tintColor = [UIColor whiteColor];
                        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [button1 addTarget:self action:@selector(addfactorfun:) forControlEvents:UIControlEventTouchUpInside];
                        button1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        button1.userInteractionEnabled=YES;
                        [mainScroll addSubview:button1];
                        
                        vi2 = [[UIView alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-124)/2, 249,124,50)];
                        vi2.layer.masksToBounds=YES;
                        vi2.layer.cornerRadius = 10.0;
                        vi2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi2.layer.borderWidth = 0.0;
                        vi2.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [mainScroll addSubview:vi2];
                        
                        button2 = [[UIButton alloc] initWithFrame:CGRectMake((mainScroll.frame.size.width-122)/2, 250,122,48)];
                        button2.layer.masksToBounds=YES;
                        button2.layer.cornerRadius = 10.0;
                        //button2.titleLabel.text = @"Сохранить";
                        [button2 setTitle:@"Сохранить" forState:UIControlStateNormal];
                        button2.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button2.layer.borderWidth = 3.0;
                        button2.titleLabel.font = [UIFont systemFontOfSize:20];
                        button2.tintColor = [UIColor whiteColor];
                        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [button2 addTarget:self action:@selector(senddata:) forControlEvents:UIControlEventTouchUpInside];
                        button2.backgroundColor = [Functions colorWithRGBHex:0x78aa45];
                        button2.userInteractionEnabled=YES;
                        [mainScroll addSubview:button2];
                    }
                    
                }
                
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
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

- (IBAction)CreateStandartFactors:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=createstandartfactors&session=%@", session];
        NSLog(@"%@",myurl);
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"EnterDairyViewController"];
                [self presentViewController:viewController animated:NO completion:nil];
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
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

- (void)senddata:(UIButton*)button
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSMutableDictionary *mydata = [[NSMutableDictionary alloc]
                  initWithCapacity:[count intValue]];
        for(UIView * subView in mainScroll.subviews )
        {
            if([subView isKindOfClass:[UITextField class]])
            {
                UITextField *mytext = (UITextField *)subView;
                NSString *encodedString = [mytext.text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                [mydata setValue:encodedString forKey:[NSString stringWithFormat:@"%i",mytext.tag]];
            }
        }
        //[mydata setValue:x forKey:key];
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:mydata options:kNilOptions error:Nil];
       // NSString *responseString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString *ur=@"";
        for (id key in [mydata allKeys])
        {
            ur = [NSString stringWithFormat:@"%@&factor[%@]=%@",ur, key, [mydata objectForKey:key]];
        }
        
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=addnewfactor&session=%@%@", session, ur];
        NSLog(@"%@",myurl);
        NSDictionary* cookie = [Functions SendGetRequest:myurl];        

        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DairyViewController"];
                [self presentViewController:viewController animated:NO completion:nil];
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
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

- (void)addfactorfun:(UIButton*)button
{

    
    UITextField *text3 = [[UITextField alloc] initWithFrame:CGRectMake(60, button1.frame.origin.y,self.view.frame.size.width-120,40)];
    text3.layer.masksToBounds=YES;
    text3.layer.cornerRadius = 5.0;
    text3.text = @"";
    text3.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    text3.backgroundColor = [UIColor whiteColor];
    text3.layer.borderWidth = 1.0;
    text3.font = [UIFont systemFontOfSize:10];
    text3.userInteractionEnabled=YES;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    text3.leftView = paddingView3;
    text3.leftViewMode = UITextFieldViewModeAlways;
    cc--;
    text3.tag=cc;
    [mainScroll addSubview:text3];
    
    CGRect newFrame = button1.frame;
    newFrame.origin.y = button1.frame.origin.y+60;
    button1.frame = newFrame;
    
    newFrame = vi1.frame;
    newFrame.origin.y = vi1.frame.origin.y+60;
    vi1.frame = newFrame;
    
    newFrame = button2.frame;
    newFrame.origin.y = button2.frame.origin.y+60;
    button2.frame = newFrame;
    
    newFrame = vi2.frame;
    newFrame.origin.y = vi2.frame.origin.y+60;
    vi2.frame = newFrame;

    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, mainScroll.contentSize.height+80);
    
    count = [NSNumber numberWithInt:count.intValue + 1];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"ssss");
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.nextResponder touchesMoved:touches withEvent:event];
    //[super touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if([touch view].tag)
    {
        
    }
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // NSLog(@"ssssssssss");
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

@end
