//
//  DairyViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 03.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "DairyViewController.h"
#import "Functions.h"
#import "AppDelegate.h"
#import "FPPopoverController.h"
#import "PopoverViewController.h"

@interface DairyViewController ()

@end

@implementation DairyViewController

@synthesize StartDateEdit;//=_StartDateEdit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)KeyboardHide:(id)sender
{
    [self.StartDateEdit resignFirstResponder];
    [self.EndDateEdit resignFirstResponder];
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


-(void)getGrafik:(NSString*)session datestart:(NSString*)start dateend:(NSString*)end
{
    
    //получение графика
    /*NSString *myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=grafik&session=%@", session];
    if ([start length]) {
        myurl = [NSString stringWithFormat:@"%@&start_date=%@",myurl, start];
    }
    if ([end length]) {
        myurl = [NSString stringWithFormat:@"%@&end_date=%@",myurl, end];
    }
    NSURL *ImageURL = [NSURL URLWithString: myurl];
     
    NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
    UIImage *image;
    if(data.bytes)
    {
        image = [[UIImage alloc] initWithData: data];
        [self.Grafik setImage:image];
    }
    //получение легенды графика
    myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=grafik_legend&session=%@", session];
    if ([start length]) {
        myurl = [NSString stringWithFormat:@"%@&start_date=%@",myurl, start];
    }
    if ([end length]) {
        myurl = [NSString stringWithFormat:@"%@&end_date=%@",myurl, end];
    }*/

    /*NSDictionary* cookie = [Functions SendGetRequest:myurl];
    if(cookie)
    {
        NSString *result = cookie[@"result"];
        NSLog(@"result: %@", result);
        if(result.boolValue)
        {
            NSArray* name = [cookie objectForKey:@"legend"];
            NSLog(@"count:%d",name.count);
            CGFloat yOrigin=230;
            for(int i=0;i<name.count;i++)
            {
                yOrigin=yOrigin+30;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, yOrigin,self.view.frame.size.width,30)];
                label.text = [NSString stringWithFormat:@"%@", [name[i] objectForKey:@"text"]];
                [self.view addSubview:label];
            //[UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]
            }
        }
        else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }*/

}

+ (void)AddFactors: (NSDictionary*)factors
{
    /*int i=0;
    for (id key in [factors allKeys])
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 40+250*i, MainScroll.frame.size.width-60,30)];
        label.text = [NSString stringWithFormat:@"%@", [legend1 objectForKey:key]];
        [self.MainScroll addSubview:label];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40+200+250*i,MainScroll.frame.size.width-60,40)];
        button1.layer.masksToBounds=YES;
        button1.layer.cornerRadius = 5.0;
        button1.titleLabel.text = @"Удалить фактор";
        button1.layer.borderColor = [[UIColor blackColor] CGColor];
        button1.layer.borderWidth = 1.0;
        button1.titleLabel.font = [UIFont systemFontOfSize:14];
        button1.userInteractionEnabled=YES;
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
        [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        
        [self.MainScroll addSubview:button1];

        i++;
    }*/

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
    //self.AddFactor.numberOfLines = 0;
    self.AddFactor.titleLabel.textAlignment = UITextAlignmentCenter;
    //[Functions MyGradientForView:self.GrafView];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    self.BottomView.delegate = self;
    
    self.AddFactor.layer.masksToBounds=YES;
    self.AddFactor.layer.cornerRadius = 10.0;
    self.AddFactor.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.AddFactor.layer.borderWidth = 3.0;
    
    self.AddFactorView.layer.masksToBounds=YES;
    self.AddFactorView.layer.cornerRadius = 10.0;
    self.AddFactorView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.AddFactorView.layer.borderWidth = 0.0;
    
    self.ChangeFactor.layer.masksToBounds=YES;
    self.ChangeFactor.layer.cornerRadius = 10.0;
    self.ChangeFactor.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.ChangeFactor.layer.borderWidth = 3.0;

    self.ChangeFactorView.layer.masksToBounds=YES;
    self.ChangeFactorView.layer.cornerRadius = 10.0;
    self.ChangeFactorView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.ChangeFactorView.layer.borderWidth = 0.0;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
	// Do any additional setup after loading the view.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    NSLog(@"%@",session);
    if ([session length]) {
        //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [self getGrafik:session datestart:@"" dateend:@""];
        
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    [self.StartDateButton addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.EndDateButton addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.StartDateEdit addTarget:self action:@selector(popover:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.EndDateEdit addTarget:self action:@selector(popover:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *vcs = appDelegate.window.rootViewController.childViewControllers;
    //UIViewController *fvc  = [vcs objectAtIndex:0];
    //UIViewController *svc = [vcs objectAtIndex:1];
}

-(void)popover:(id)sender
{
    //the controller we want to present as a popover
    PopoverViewController *controller = [[PopoverViewController alloc] init];
    
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    //if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(self.view.frame.size.width, 320);
    }
    popover.arrowDirection = FPPopoverArrowDirectionUp;
    popover.tint=FPPopoverGreenTint;
    
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];
    
}

//изменить факторы
- (IBAction)EnterData:(id)sender {
    /*
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"EnterDairyViewController"];
    [self presentViewController:viewController animated:NO completion:nil];*/
}

//добавить фактор
- (IBAction)ReplaceData:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"EnterDairyViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
