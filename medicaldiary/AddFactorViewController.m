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

    self.MainScroll.layer.zPosition=0;
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
                
                NSDictionary* name = [cookie objectForKey:@"grafik_data"];
                NSDictionary* legend = [cookie objectForKey:@"gettodaydata"];
                
                NSString *empty = [cookie objectForKey:@"empty"];
                NSNumber *count = [cookie objectForKey:@"count"];
                self.MainScroll.contentSize = CGSizeMake(self.view.frame.size.width,[count intValue]*250+40+100);
                
                dataArray = [[NSMutableArray alloc] init];
                
                // Add some data for demo purposes.
                for(int i=1;i<11;i++) [dataArray addObject:[NSString stringWithFormat:@"%i", i]];
                if(0)//[empty intValue]==0)
                {
                    for (id key in [name allKeys]) {
                        //NSLog(@"%@ - %@",key,[name objectForKey:key]);
                        /*NSArray* point = [name objectForKey:key];
                         CGContextSetLineWidth(context, 1.5f);
                         NSArray *c1 = [colors objectForKey:key];
                         CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
                         CGFloat components[] = {[c1[0] floatValue]/255.0f, [c1[1] floatValue]/255.0f, [c1[2] floatValue]/255.0f, 1.0f};
                         CGColorRef color = CGColorCreate(colorspace, components);
                         CGContextSetStrokeColorWithColor(context, color);
                         NSString *dd = [point[0] objectForKey:@"date"];
                         int i1=0;
                         while(![dd isEqualToString:dates[i1]])
                         {
                         i1++;
                         }
                         
                         //CGContextMoveToPoint(context, lof + (i1*(wid-lof)/(dates.count-1)), middle*10 - ([[point[0] objectForKey:@"value"] intValue]*middle));
                         
                         //NSLog(@"%@ - %d",[point[0] objectForKey:@"date"],[[point[0] objectForKey:@"value"] intValue]);
                         for(int i=1;i<point.count;i++)
                         {
                         i1=0;
                         dd = [point[i] objectForKey:@"date"];
                         
                         while(![dd isEqualToString:dates[i1]])
                         {
                         i1++;
                         }
                         CGContextMoveToPoint(context, lof + ((i1-1)*(wid-lof)/(dates.count-1)), middle*10 - ([[point[i-1] objectForKey:@"value"] intValue]*middle));
                         CGContextAddLineToPoint(context, lof+(i1*(wid-lof)/(dates.count-1)), middle*10 - ([[point[i] objectForKey:@"value"] intValue]*middle));
                         //CGContextAddLineToPoint(context, 270.0f, 5.0f);
                         CGContextStrokePath(context);
                         }*/
                    }
                }
                else
                {
                    int i=0;
                    if(legend)
                    {
                        NSDictionary* legend1 = [legend objectForKey:@"legenda"];
                        self.View1.hidden = YES;
                        CGRect newFrame = self.MainScroll.frame;
                        newFrame.size.height = self.BottomView.frame.origin.y-self.MainScroll.frame.origin.y;
                        self.MainScroll.frame = newFrame;
                        NSLog(@"%f",self.BottomView.frame.origin.y-self.MainScroll.frame.origin.y);
                        //self.MainScroll.frame.size = CGSizeMake(self.view.frame.size.width, [count intValue]*60+110);
                        
                        mainScroll = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 76, self.view.frame.size.width, self.BottomView.frame.origin.y-76)];
                        
                        self.MainScroll.contentSize = CGSizeMake(self.view.frame.size.width, [count intValue]*60+110);
                        for (id key in [legend1 allKeys])
                        {
                            UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(60, 20+i*60,self.view.frame.size.width-120,40)];
                            text1.layer.masksToBounds=YES;
                            text1.layer.cornerRadius = 5.0;
                            text1.text = [NSString stringWithFormat:@"%@", [legend1 objectForKey:key]];
                            text1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                            text1.backgroundColor = [UIColor whiteColor];
                            text1.layer.borderWidth = 1.0;
                            text1.font = [UIFont systemFontOfSize:10];
                            text1.userInteractionEnabled=YES;
                            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                            text1.leftView = paddingView;
                            text1.leftViewMode = UITextFieldViewModeAlways;
                            [self.MainScroll addSubview:text1];
                            
                            i++;
                            
                        }
                        
                        vi1 = [[UIView alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-162)/2, 20+20+i*60-1,162,38)];
                        vi1.layer.masksToBounds=YES;
                        vi1.layer.cornerRadius = 10.0;
                        vi1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi1.layer.borderWidth = 0.0;
                        vi1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:vi1];
                        
                        button1 = [[UIButton alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-162)/2+1, 20+20+i*60,160,36)];
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
                        [self.MainScroll addSubview:button1];
                        
                        vi2 = [[UIView alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-124)/2, 20+20+i*60+50-1,124,50)];
                        vi2.layer.masksToBounds=YES;
                        vi2.layer.cornerRadius = 10.0;
                        vi2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi2.layer.borderWidth = 0.0;
                        vi2.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:vi2];
                        
                        button2 = [[UIButton alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-122)/2, 20+20+i*60+50,122,48)];
                        button2.layer.masksToBounds=YES;
                        button2.layer.cornerRadius = 10.0;
                        //button2.titleLabel.text = @"Сохранить";
                        [button2 setTitle:@"Сохранить" forState:UIControlStateNormal];
                        button2.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button2.layer.borderWidth = 3.0;
                        button2.titleLabel.font = [UIFont systemFontOfSize:20];
                        button2.tintColor = [UIColor whiteColor];
                        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        //[button1 addTarget:self action:@selector(senddata:) forControlEvents:UIControlEventTouchUpInside];
                        button2.backgroundColor = [Functions colorWithRGBHex:0x78aa45];
                        button2.userInteractionEnabled=YES;
                        [self.MainScroll addSubview:button2];

                    }
                    else
                    {
                        CGRect newFrame = self.MainScroll.frame;
                        newFrame.size.height = self.BottomView.frame.origin.y-self.MainScroll.frame.origin.y-self.View1.frame.size.height;
                        self.MainScroll.frame = newFrame;
                        
                        self.MainScroll.contentSize = CGSizeMake(self.view.frame.size.width, 320);
                        
                        self.View1.hidden = NO;
                        
                        UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(60, 20,self.view.frame.size.width-120,40)];
                        text1.layer.masksToBounds=YES;
                        text1.layer.cornerRadius = 5.0;
                        text1.text = @"Качество массажа";
                        text1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                        text1.backgroundColor = [UIColor whiteColor];
                        text1.layer.borderWidth = 1.0;
                        text1.font = [UIFont systemFontOfSize:14];
                        text1.userInteractionEnabled=YES;
                        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                        text1.leftView = paddingView;
                        text1.leftViewMode = UITextFieldViewModeAlways;
                        [self.MainScroll addSubview:text1];
                        
                        UITextField *text2 = [[UITextField alloc] initWithFrame:CGRectMake(60, 80,self.view.frame.size.width-120,40)];
                        text2.layer.masksToBounds=YES;
                        text2.layer.cornerRadius = 5.0;
                        text2.text = @"Выброс эндорфина";
                        text2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                        text2.backgroundColor = [UIColor whiteColor];
                        text2.layer.borderWidth = 1.0;
                        text2.font = [UIFont systemFontOfSize:14];
                        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                        text2.userInteractionEnabled=YES;
                        text2.leftView = paddingView2;
                        text2.leftViewMode = UITextFieldViewModeAlways;
                        [self.MainScroll addSubview:text2];
                        
                        UITextField *text3 = [[UITextField alloc] initWithFrame:CGRectMake(60, 140,self.view.frame.size.width-120,40)];
                        text3.layer.masksToBounds=YES;
                        text3.layer.cornerRadius = 5.0;
                        text3.text = @"Головная боль";
                        text3.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
                        text3.backgroundColor = [UIColor whiteColor];
                        text3.layer.borderWidth = 1.0;
                        text3.font = [UIFont systemFontOfSize:14];
                        text3.userInteractionEnabled=YES;
                        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
                        text3.leftView = paddingView3;
                        text3.leftViewMode = UITextFieldViewModeAlways;
                        [self.MainScroll addSubview:text3];
                        
                        
                        vi1 = [[UIView alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-162)/2, 199,162,38)];
                        vi1.layer.masksToBounds=YES;
                        vi1.layer.cornerRadius = 10.0;
                        vi1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi1.layer.borderWidth = 0.0;
                        vi1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:vi1];
                        
                        button1 = [[UIButton alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-162)/2+1, 200,160,36)];
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
                        [self.MainScroll addSubview:button1];
                        
                        vi2 = [[UIView alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-124)/2, 249,124,50)];
                        vi2.layer.masksToBounds=YES;
                        vi2.layer.cornerRadius = 10.0;
                        vi2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
                        vi2.layer.borderWidth = 0.0;
                        vi2.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:vi2];
                        
                        button2 = [[UIButton alloc] initWithFrame:CGRectMake((self.MainScroll.frame.size.width-122)/2, 250,122,48)];
                        button2.layer.masksToBounds=YES;
                        button2.layer.cornerRadius = 10.0;
                        //button2.titleLabel.text = @"Сохранить";
                        [button2 setTitle:@"Сохранить" forState:UIControlStateNormal];
                        button2.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button2.layer.borderWidth = 3.0;
                        button2.titleLabel.font = [UIFont systemFontOfSize:20];
                        button2.tintColor = [UIColor whiteColor];
                        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        //[button1 addTarget:self action:@selector(senddata:) forControlEvents:UIControlEventTouchUpInside];
                        button2.backgroundColor = [Functions colorWithRGBHex:0x78aa45];
                        button2.userInteractionEnabled=YES;
                        [self.MainScroll addSubview:button2];
                    }
                    /*UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40+30+250*i,self.view.frame.size.width-60,40)];
                    button1.layer.masksToBounds=YES;
                    button1.layer.cornerRadius = 5.0;
                    button1.titleLabel.text = @"Send";
                    button1.layer.borderColor = [[UIColor blackColor] CGColor];
                    button1.layer.borderWidth = 1.0;
                    button1.titleLabel.font = [UIFont systemFontOfSize:14];
                    [button1 addTarget:self action:@selector(senddata:) forControlEvents:UIControlEventTouchUpInside];
                    button1.userInteractionEnabled=YES;
                    
                    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [button1 setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
                    [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
                    [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
                    [self.MainScroll addSubview:button1];*/
                    
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

- (void)addfactorfun:(UIButton*)button
{

    
    UITextField *text3 = [[UITextField alloc] initWithFrame:CGRectMake(60, button1.frame.origin.y,self.view.frame.size.width-120,40)];
    text3.layer.masksToBounds=YES;
    text3.layer.cornerRadius = 5.0;
    text3.text = @"";
    text3.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    text3.backgroundColor = [UIColor whiteColor];
    text3.layer.borderWidth = 1.0;
    text3.font = [UIFont systemFontOfSize:14];
    text3.userInteractionEnabled=YES;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    text3.leftView = paddingView3;
    text3.leftViewMode = UITextFieldViewModeAlways;
    [self.MainScroll addSubview:text3];
    
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

    self.MainScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.MainScroll.contentSize.height+60);
    
    
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
