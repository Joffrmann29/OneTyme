//
//  AttorneyViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/27/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "AttorneyViewController.h"
#import "AppDelegate.h"
#import "Attorney.h"

@interface AttorneyViewController ()

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AttorneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *oneTymeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttorneyBackground.png"]];
    oneTymeImage.frame = CGRectMake(0, 64, self.view.frame.size.width, 663);
    [self.view addSubview:oneTymeImage];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setTitle:@"Current Location" forState:UIControlStateNormal];
    locationButton.frame = CGRectMake(70.5, 128, 273, 79);
    CALayer *locationLayer = locationButton.layer;
    locationLayer = [self gradientBGLayerForBounds:locationButton.bounds];
    locationLayer.cornerRadius = 10;
    [self.view addSubview:locationButton];
    
    UIGraphicsBeginImageContext(locationLayer.bounds.size);
    [locationLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *locationImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (locationImage != nil)
    {
        [locationButton setBackgroundImage:locationImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    UIButton *zipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zipButton setTitle:@"Zip Code" forState:UIControlStateNormal];
    zipButton.frame = CGRectMake(70.5, 261, 273, 79);
    CALayer *zipLayer = zipButton.layer;
    zipLayer = [self gradientBGLayerForBounds:zipButton.bounds];
    zipLayer.cornerRadius = 10;
    [self.view addSubview:zipButton];
    
    UIGraphicsBeginImageContext(zipLayer.bounds.size);
    [zipLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *zipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (zipImage != nil)
    {
        [zipButton setBackgroundImage:zipImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nameButton setTitle:@"Name" forState:UIControlStateNormal];
    nameButton.frame = CGRectMake(70.5, 404, 273, 79);
    CALayer *nameLayer = nameButton.layer;
    nameLayer = [self gradientBGLayerForBounds:nameButton.bounds];
    nameLayer.cornerRadius = 10;
    [self.view addSubview:nameButton];
    
    UIGraphicsBeginImageContext(nameLayer.bounds.size);
    [nameLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *nameImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (nameImage != nil)
    {
        [nameButton setBackgroundImage:nameImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    UIButton *addEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addEditButton setTitle:@"Add/edit my attorney" forState:UIControlStateNormal];
    addEditButton.frame = CGRectMake(70.5, 547, 273, 79);
    CALayer *addEditLayer = addEditButton.layer;
    addEditLayer = [self gradientBGLayerForBounds:addEditButton.bounds];
    addEditLayer.cornerRadius = 10;
    [self.view addSubview:addEditButton];
    
    UIGraphicsBeginImageContext(addEditLayer.bounds.size);
    [addEditLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *addEditImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (addEditImage != nil)
    {
        [addEditButton setBackgroundImage:addEditImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CALayer *)gradientBGLayerForBounds:(CGRect)bounds
{
    CAGradientLayer * gradientBG = [CAGradientLayer layer];
    gradientBG.frame = bounds;
    gradientBG.colors = [NSArray arrayWithObjects:
                         (id)[[UIColor blackColor] CGColor],
                         (id)[[UIColor darkGrayColor] CGColor],
                         nil];
    return gradientBG;
}


-(void)didAddBailsBonds:(Attorney *)attorney
{
    [_appDelegate.AttorneyDataArray addObject:attorney];
    
    /* Use NSUserDefaults to access all previously saved tasks. If there were not saved tasks we allocate and initialize the NSMutableArray named taskObjectsAsPropertyLists. */
    NSMutableArray *attorneyObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ATTORNEY_OBJECTS_KEY] mutableCopy];
    if (!attorneyObjectsAsPropertyLists) attorneyObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    /* First convert the task object to a property list using the method taskObjectAsAPropertyList. Then add the propertylist (dictionary) to the taskObjectsAsPropertyLists NSMutableArray. Synchronize will save the added array to NSUserDefaults.*/
    [attorneyObjectsAsPropertyLists addObject:[self attorneyObjectsAsAPropertyList:attorney]];
    [[NSUserDefaults standardUserDefaults] setObject:attorneyObjectsAsPropertyLists forKey:ATTORNEY_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

/* Convert and return an NSDictionary of the taskObject */
-(NSDictionary *)attorneyObjectsAsAPropertyList:(Attorney *)attorneyObject
{
    NSDictionary *dictionary = @{NAME : attorneyObject.name, ADDRESS : attorneyObject.address, CITY : attorneyObject.city, STATE : attorneyObject.state, ZIP_CODE : attorneyObject.zipCode, PHONE_NO : attorneyObject.phone, SECONDARY_PHONE_NO : attorneyObject.secondaryPhone, EMAIL : attorneyObject.email };
    return dictionary;
}


-(Attorney *)attorneyObjectForDictionary:(NSDictionary *)dictionary
{
    Attorney *attorneyObject = [[Attorney alloc] initWithAttorney:dictionary];
    return attorneyObject;
}

#pragma - Subviews

-(void) addAttorneyDetailSubview{
    
    ads = [[UIView alloc] initWithFrame:CGRectMake(75, 50, 184, 220)];
    
    bbds.backgroundColor = [UIColor blackColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(6, 7, 140, 25)];
    lblTitle.text = @"Bail Bonds Details";
    [bbds addSubview:lblTitle];
    
    UITextField *txtFullName = [[UITextField alloc] initWithFrame:CGRectMake(10, 36, 174, 30)];
    txtFullName.placeholder = @"Full Name";
    [bbds addSubview:txtFullName];
    
    UITextField *txtAddress = [[UITextField alloc] initWithFrame:CGRectMake(10, 73, 174, 30)];
    txtFullName.placeholder = @"Address";
    [bbds addSubview:txtAddress];
    
    UITextField *txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(10, 109, 174, 30)];
    txtFullName.placeholder = @"Mobile/Landline";
    [bbds addSubview:txtPhone];
    
    UITextField *txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, 174, 30)];
    txtFullName.placeholder = @"Email";
    [bbds addSubview:txtEmail];
    
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(6, 182, 82, 30)];
    [btnLeft setTitle:@"Submit" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [bbds addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(6, 182, 82, 30)];
    [btnLeft setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [bbds addSubview:btnRight];
    
    [self.view addSubview:bbds];
    
}

-(void)addSearchName{
    
    [self addSearchView:@"Name"];
}

-(void)addSearchZip{
    
    [self addSearchView:@"Zip"];
}

-(void)addSearchView:(NSString *)searchType{
    
    search = [[UIView alloc] initWithFrame:CGRectMake(68, 122, 184, 120)];
    
    search.backgroundColor = [UIColor blackColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 10, 138, 21)];
    lblTitle.text = searchType;
    [search addSubview:lblTitle];
    
    UITextField *txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(5, 39, 138, 21)];
    //txtSearch.placeholder = @"Type search here";
    [search addSubview:txtSearch];
    
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(7, 77, 82, 30)];
    [btnLeft setTitle:@"Submit" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [search addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(95, 77, 82, 30)];
    [btnLeft setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [search addSubview:btnRight];
    
    [self.view addSubview:search];
}

-(void)dismissViewSearch
{
    [search removeFromSuperview];
}


@end
