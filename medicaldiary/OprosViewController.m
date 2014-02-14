//
//  OprosViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 04.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "OprosViewController.h"
#import "AppDelegate.h"
#import "Functions.h"
#import "MySingleton.h"

@interface OprosViewController ()

@end

@implementation OprosViewController

@synthesize profile;

NSMutableArray *dataArray;
NSArray *variants;
int ques_id,answer_id;
NSArray *oproses;

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
    if(item.tag==3)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"PedometrViewController"];
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:viewController animated:NO completion:nil];
    }
}

- (void)GetOpros
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=getnextopros&session=%@", session];
        
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                NSString* question = [cookie objectForKey:@"question"];
                variants = [cookie objectForKey:@"variants"];
                ques_id = [[cookie objectForKey:@"question_id"] intValue];
                answer_id = 0;
                if(variants.count>0)
                {
                    [dataArray removeAllObjects];
                    self.question.text = question;
                    [dataArray addObject:@""];
                    for (int i=0;i<variants.count;i++)
                    {
                        [dataArray addObject:[NSString stringWithFormat:@"%@", [variants[i] objectForKey:@"value"]]];
                    }
                    [self.picker reloadAllComponents];
                    [self.picker selectRow:0 inComponent:0 animated:YES];
                }
                else
                {
                    [self getresult];
                }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *wh = [dataArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier=@"bla-bla";
    int i=0;
    for (i=0;i<dataArray.count;i++)
    {
        if([wh isEqualToString:[oproses[i] objectForKey:@"question"]])
        {
            CellIdentifier = [NSString stringWithFormat:@"%i",[[oproses[i] objectForKey:@"id"] intValue]];
            break;
        }
        
    }
    
    UITableViewCell *cell;
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.tag = [[oproses[i] objectForKey:@"id"] intValue];
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines=0;
    UIFont *myFont = [ UIFont systemFontOfSize:12.0 ];
    cell.textLabel.font  = myFont;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    /*UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    city_str = cell.textLabel.text;
    for (int i=0;i<cities.count;i++)
    {
        if([city_str isEqualToString:[cities[i] objectForKey:@"name"]])
        {
            city1=i;
            break;
        }
        
    }
    city1 = cell.tag;
    NSLog(@"city=%i %@",city1,[NSNumber numberWithInt:city1]);
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%i",city1] forKey:@"city"];
    [NSString stringWithFormat:@"%i",city1];
    [userDefaults setObject:city_str forKey:@"city_str"];
    [userDefaults synchronize];
    self.city_str.text = city_str;
    self.citytable.hidden = YES;*/
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [MySingleton sharedMySingleton].profile=cell.tag;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ResultOprosViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
    
}

-(void)getresult
{
    self.question.hidden=YES;
    self.sendotvet.hidden=YES;
    self.sendotvetview.hidden=YES;
    self.picker.hidden=YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=getoprosresult&session=%@", session];
        
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                oproses = cookie[@"oproses"];
                if(oproses.count)
                {
                    for (int i=0;i<oproses.count;i++)
                    {
                        [dataArray addObject:[NSString stringWithFormat:@"%@", [oproses[i] objectForKey:@"question"]]];
                    }

                    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width-20, self.BottomView.frame.origin.y - 30) style:UITableViewStylePlain];
                    tableView.delegate = self;
                    tableView.dataSource = self;
                    tableView.scrollEnabled = YES;
                    tableView.showsVerticalScrollIndicator = YES;
                    tableView.userInteractionEnabled = YES;
                    tableView.bounces = YES;
                    [self.view addSubview:tableView];
                }
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

- (IBAction)SendOtvet:(UIButton *)sender {
    
    if(answer_id)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *session = [userDefaults objectForKey:@"session"];
        if ([session length]) {
            NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
            NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=sendanswer&session=%@&id=%i&answer=%i", session, ques_id, answer_id];
            NSLog(@"%@",myurl);
            NSDictionary* cookie = [Functions SendGetRequest:myurl];
            if(cookie)
            {
                NSString *result = cookie[@"result"];
                NSLog(@"result: %@", result);
                if(result.boolValue)
                {
                    
                    [self GetOpros];
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
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Выберите вариант ответа!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

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
    
    NSLog(@"You selected this: %@ %i", [dataArray objectAtIndex: row], row);
    if(row!=0)
    {
        for (int i=0;i<variants.count;i++)
        {
            if([[variants[i] objectForKey:@"value"] isEqualToString:[dataArray objectAtIndex:row]])
            {
                answer_id = [[variants[i] objectForKey:@"id"] intValue];
            }
        }
    }
    else answer_id=0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
#define PICKER_LABEL_FONT_SIZE 14
    
#define PICKER_LABEL_ALPHA 0.7
    
    UILabel *carsLabel = nil;  UIFont *font = nil;
    
    if (component == 0)
        
    {
        carsLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.picker.frame.size.width, 40)];
        carsLabel.font = [UIFont systemFontOfSize:13];
        carsLabel.text = [dataArray objectAtIndex:(int)row];
        carsLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        carsLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 90, 40)];
        carsLabel.font = [UIFont systemFontOfSize:13];
        carsLabel.text = [dataArray objectAtIndex:(int)row];
        carsLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    carsLabel.textColor = [UIColor blackColor];
    carsLabel.backgroundColor = [UIColor clearColor];
    carsLabel.opaque = NO;
    [view addSubview:carsLabel];
    
    return carsLabel;
    
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.TargetPicker selectRow:rr inComponent:0 animated:YES];
    
    [self GetOpros];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Functions MyGradient:self.view];
	// Do any additional setup after loading the view.
    [super viewDidLoad];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.BottomView.delegate = self;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:2]];
    self.sendotvet.layer.masksToBounds=YES;
    self.sendotvet.layer.cornerRadius = 10.0;
    self.sendotvet.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.sendotvet.layer.borderWidth = 3.0;
    
    self.sendotvetview.layer.masksToBounds=YES;
    self.sendotvetview.layer.cornerRadius = 10.0;
    self.sendotvetview.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.sendotvetview.layer.borderWidth = 0.0;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    self.question.numberOfLines = 0;
    
    [self.picker setDataSource: self];
    [self.picker setDelegate: self];
    
    dataArray = [[NSMutableArray alloc] init];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
