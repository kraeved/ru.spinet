//
//  ResultOprosViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "ResultOprosViewController.h"
#import "Functions.h"
#import "MySingleton.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomScrollView.h"
#import "AppDelegate.h"

@interface ResultOprosViewController ()

@end

@implementation ResultOprosViewController

NSMutableArray *dataarray;
XYPieChart *pieChart1;
NSArray        *sliceColors;
CustomScrollView* scrollView;

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
    //OprosViewController
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [pieChart1 reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.BottomView.delegate = self;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:2]];
	// Do any additional setup after loading the view.
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    NSLog(@"%i",[MySingleton sharedMySingleton].profile);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    CustomScrollView* scrollView = [[CustomScrollView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.BottomView.frame.origin.y - 55)];
    [self.view addSubview:scrollView];
    if ([session length]) {
        
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=getoprosgrafik&session=%@&id=%i", session, [MySingleton sharedMySingleton].profile];
        NSLog(@"%@", myurl);
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
                if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                NSString* question = [cookie objectForKey:@"question"];
                NSArray* values = [cookie objectForKey:@"opros_result"];
                dataarray = [NSMutableArray arrayWithCapacity:values.count];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,20,scrollView.frame.size.width-20,80)];
                label.text = question;
                label.font = [UIFont fontWithName:@"Arial" size:(12.0)];
                label.numberOfLines=0;
                label.textAlignment = NSTextAlignmentCenter;
                [scrollView addSubview:label];
                
                for(int i = 0; i < values.count; i ++)
                {
                    [dataarray addObject:[NSString stringWithFormat:@"%@", [values[i] objectForKey:@"count"]]];
                    
                }
                
                pieChart1 = [[XYPieChart alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width-60, self.view.frame.size.width-60)];
                pieChart1.delegate = self;
                pieChart1.DataSource=self;
                [pieChart1 setStartPieAngle:M_PI_2];
                [pieChart1 setAnimationSpeed:1.0];
                [pieChart1 setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
                [pieChart1 setLabelRadius:120];
                [pieChart1 setShowPercentage:NO];
                [pieChart1 setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
                [pieChart1 setPieCenter:CGPointMake((self.view.frame.size.width-20)/2, 200)];
                [pieChart1 setUserInteractionEnabled:NO];
                [pieChart1 setLabelShadowColor:[UIColor blackColor]];
                
                sliceColors =[NSArray arrayWithObjects:
                              [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                              [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                              [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                              [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                              [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
                [scrollView addSubview:pieChart1];
                [pieChart1 reloadData];

                
                scrollView.contentSize = CGSizeMake(self.view.frame.size.width,values.count*30+pieChart1.frame.origin.y+pieChart1.frame.size.height+30+50);
                for(int i = 0; i < values.count; i ++)
                {
                    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10,pieChart1.frame.origin.y+pieChart1.frame.size.height+20+50+i*30+5,10,10)];
                    view1.backgroundColor = [sliceColors objectAtIndex:(i % sliceColors.count)];
                    [scrollView addSubview:view1];
                    
                    
                    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30,pieChart1.frame.origin.y+pieChart1.frame.size.height+20+50+i*30,scrollView.frame.size.width-40,20)];
                    label1.text = [NSString stringWithFormat:@"%@ - %@", [values[i] objectForKey:@"value"],[values[i] objectForKey:@"count"]];
                    label1.font = [UIFont fontWithName:@"Arial" size:(11.0)];
                    label1.numberOfLines=0;
                    //label1.textAlignment = NSTextAlignmentCenter;
                    [scrollView addSubview:label1];

                }
                
                
                //rotate up arrow
                //self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);

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

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return dataarray.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[dataarray objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    //if(pieChart == pieChart1) return nil;
    return [sliceColors objectAtIndex:(index % sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
    //self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[dataarray objectAtIndex:index]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
