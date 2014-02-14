//
//  EnterDairyViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "EnterDairyViewController.h"
#import "AppDelegate.h"
#import "Functions.h"

@interface EnterDairyViewController ()

@end

@implementation EnterDairyViewController

NSMutableArray *dataArray;
NSMutableDictionary *mydata;


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
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
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
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    self.BottomView.delegate = self;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    CGRect newFrame = self.MainScroll.frame;
    newFrame.size.height = self.BottomView.frame.origin.y;
    self.MainScroll.frame = newFrame;
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
        
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {

                NSDictionary* name = [cookie objectForKey:@"grafik_data"];
                NSDictionary* legend = [cookie objectForKey:@"gettodaydata"];
                NSDictionary* legend1 = [legend objectForKey:@"legenda"];
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
                    mydata = [[NSMutableDictionary alloc]
                     initWithCapacity:[count intValue]];
                    for (id key in [legend1 allKeys])
                    {
                        //NSLog(@"%@ - %@",key,[legend1 objectForKey:key]);
                        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 40+40+250*i, self.view.frame.size.width-60, 150)];
                        [picker setDataSource: self];
                        [picker setDelegate: self];
                        
                        picker.showsSelectionIndicator = YES;
                        [self.MainScroll addSubview:picker];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 40+250*i,self.view.frame.size.width-60,30)];
                        label.text = [NSString stringWithFormat:@"%@", [legend1 objectForKey:key]];
                        [self.MainScroll addSubview:label];
                        
                        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40+200+250*i,self.view.frame.size.width-60,40)];
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
                        
                        [button1 addTarget:self action:@selector(deletefactor:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [self.MainScroll addSubview:button1];
                        
                        button1.tag= [key intValue];
                        label.tag= [key intValue];
                        picker.tag= [key intValue];
                        NSNumber *x;
                        x=[NSNumber numberWithInt:1];
                        
                        [mydata setValue:x forKey:key];
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mydata];
                        NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        //NSLog(@"%@",[mydata objectForKey:key]);

                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:data forKey:@"factor"];
                        [userDefaults synchronize];
                        i++;
                    }
                    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40+30+250*i,self.view.frame.size.width-60,40)];
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
                    [self.MainScroll addSubview:button1];

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

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"You selected this: %@ %d", [dataArray objectAtIndex: row], pickerView.tag);
    [mydata setValue:[dataArray objectAtIndex: row] forKey:[NSString stringWithFormat:@"%i", pickerView.tag]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mydata];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:@"factor"];
    [userDefaults synchronize];
    /*
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     NSString *session = [userDefaults objectForKey:@"session"];
     */
}

-(void)deletefactor:(UIButton*)sender
{
    NSLog(@"delete factor #%i",sender.tag);
}

-(void)senddata:(UIButton*)sender
{
    NSLog(@"HTllo %i",sender.tag);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"factor"];
    NSDictionary *items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:items options:NSJSONWritingPrettyPrinted error:Nil];
    //return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    //for (id key in [items allKeys]) NSLog(@"%@",key);
}
@end
