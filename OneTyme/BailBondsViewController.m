//
//  BailBondsViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "BailBondsViewController.h"

@interface BailBondsViewController ()<UITextFieldDelegate>{
    UIView *bbds;
    UIView *search;
    UIView *searchName;
    BOOL isZipClicked;
    BOOL isNameClicked;
    BOOL isBailBondsClicked;
    UITextField *txtFullName;
    UITextField *txtAddress;
    UITextField *txtPhone;
    UITextField *txtSecondaryPhone;
    UITextField *txtEmail;
}

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BailBondsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    isZipClicked = NO;
    isNameClicked = NO;
    isBailBondsClicked = NO;
    
//    //BailBonds *bailBonds = [[NSUserDefaults standardUserDefaults] arrayForKey:BAILBONDS_OBJECTS_KEY];
//    
//    NSLog(@"%@", bailBonds.email);
    
    UIImageView *oneTymeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttorneyBackground.png"]];
    oneTymeImage.frame = CGRectMake(0, 64, self.view.frame.size.width, 663);
    [self.view addSubview:oneTymeImage];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setTitle:@"Current Location" forState:UIControlStateNormal];
    locationButton.frame = CGRectMake(70.5, 128, 273, 79);
    CALayer *locationLayer = locationButton.layer;
    locationLayer = [self gradientBGLayerForBounds:locationButton.bounds];
    locationLayer.cornerRadius = 10;
    //[locationButton addTarget:self action:@selector(ad) forControlEvents:<#(UIControlEvents)#>]
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
    [zipButton addTarget:self action:@selector(addSearchZip) forControlEvents:UIControlEventTouchUpInside];
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
    [nameButton addTarget:self action:@selector(addSearchName) forControlEvents:UIControlEventTouchUpInside];

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
    [addEditButton setTitle:@"Add/edit my Bail Bonds" forState:UIControlStateNormal];
    addEditButton.frame = CGRectMake(70.5, 547, 273, 79);
    [addEditButton addTarget:self action:@selector(addBailBonds) forControlEvents:UIControlEventTouchUpInside];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

-(void)didAddBailsBonds:(BailBonds *)bailBonds
{
    [_appDelegate.BailBondsDataArray addObject:bailBonds];
    
    /* Use NSUserDefaults to access all previously saved tasks. If there were not saved tasks we allocate and initialize the NSMutableArray named taskObjectsAsPropertyLists. */
    NSMutableArray *bailBondsObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:BAILBONDS_OBJECTS_KEY] mutableCopy];
    if (!bailBondsObjectsAsPropertyLists) bailBondsObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    /* First convert the task object to a property list using the method taskObjectAsAPropertyList. Then add the propertylist (dictionary) to the taskObjectsAsPropertyLists NSMutableArray. Synchronize will save the added array to NSUserDefaults.*/
    [bailBondsObjectsAsPropertyLists addObject:[self bailBondsObjectsAsAPropertyList:bailBonds]];
    [[NSUserDefaults standardUserDefaults] setObject:bailBondsObjectsAsPropertyLists forKey:BAILBONDS_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

/* Convert and return an NSDictionary of the taskObject */
-(NSDictionary *)bailBondsObjectsAsAPropertyList:(BailBonds *)bailBondsObject
{
    NSDictionary *dictionary = @{NAME : bailBondsObject.name, ADDRESS : bailBondsObject.address, CITY : bailBondsObject.city, STATE : bailBondsObject.state, ZIP_CODE : bailBondsObject.zipCode, PHONE_NO : bailBondsObject.phone, SECONDARY_PHONE_NO : bailBondsObject.secondaryPhone, EMAIL : bailBondsObject.email };
    return dictionary;
}


-(BailBonds *)bailBondsObjectForDictionary:(NSDictionary *)dictionary
{
    BailBonds *bailBondsObject = [[BailBonds alloc] initWithBailBonds:dictionary];
    return bailBondsObject;
}


-(void)evaluateBailBonds
{
    BailBonds *bailBonds = [[BailBonds alloc]init];
    bailBonds.name = txtFullName.text;
    bailBonds.address = txtAddress.text;
    bailBonds.city = @"N/A";
    bailBonds.state = @"N/A";
    bailBonds.phone = txtPhone.text;
    bailBonds.secondaryPhone = txtSecondaryPhone.text;
    bailBonds.email = txtEmail.text;
    [[NSUserDefaults standardUserDefaults] setObject:[self bailBondsObjectsAsAPropertyList:bailBonds] forKey:BAILBONDS_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma - Subviews

/*
 -(void)addBailBonds
 {
 if(isBailBondsClicked == NO)
 {
 [self addBailBondDetailSubview];
 isBailBondsClicked = YES;
 }
 
 else
 {
 [bbds removeFromSuperview];
 isBailBondsClicked = NO;
 }
 }*/

-(void) addBailBondDetailSubview{
    
    bbds = [[UIView alloc] initWithFrame:CGRectMake(70.5, 319, 273, 258)];
    
    bbds.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 263, 21)];
    lblTitle.text = @"Bail Bonds Details";
    [bbds addSubview:lblTitle];
    
    txtFullName = [[UITextField alloc] initWithFrame:CGRectMake(5, 36, 263, 30)];
    txtFullName.backgroundColor = [UIColor blackColor];
    txtFullName.layer.cornerRadius = 10;
    txtFullName.textColor = [UIColor whiteColor];
    txtFullName.placeholder = @"Full Name";
    [txtFullName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtFullName.textAlignment = NSTextAlignmentCenter;
    txtFullName.delegate = self;
    [bbds addSubview:txtFullName];
    
    txtAddress = [[UITextField alloc] initWithFrame:CGRectMake(5, 73, 263, 30)];
    txtAddress.backgroundColor = [UIColor blackColor];
    txtAddress.layer.cornerRadius = 10;
    txtAddress.textColor = [UIColor whiteColor];
    txtAddress.placeholder = @"Address";
    [txtAddress setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtAddress.textAlignment = NSTextAlignmentCenter;
    txtAddress.delegate = self;
    [bbds addSubview:txtAddress];
    
    txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(10, 109, 263, 30)];
    txtPhone.backgroundColor = [UIColor blackColor];
    txtPhone.layer.cornerRadius = 10;
    txtPhone.textColor = [UIColor whiteColor];
    txtPhone.placeholder = @"Mobile/Landline";
    [txtPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtPhone.textAlignment = NSTextAlignmentCenter;
    txtPhone.delegate = self;
    [bbds addSubview:txtPhone];
    
    txtSecondaryPhone = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, 263, 30)];
    txtSecondaryPhone.backgroundColor = [UIColor blackColor];
    txtSecondaryPhone.layer.cornerRadius = 10;
    txtSecondaryPhone.textColor = [UIColor whiteColor];
    txtSecondaryPhone.placeholder = @"Mobile/Landline";
    [txtSecondaryPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtSecondaryPhone.textAlignment = NSTextAlignmentCenter;
    txtSecondaryPhone.delegate = self;
    [bbds addSubview:txtSecondaryPhone];
    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(10, 182, 263, 30)];
    txtEmail.backgroundColor = [UIColor blackColor];
    txtEmail.layer.cornerRadius = 10;
    txtEmail.textColor = [UIColor whiteColor];
    txtEmail.placeholder = @"Email";
    [txtEmail setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtEmail.textAlignment = NSTextAlignmentCenter;
    txtEmail.delegate = self;
    [bbds addSubview:txtEmail];
    
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(6, 218, 125.5, 30)];
    [btnLeft setTitle:@"Submit" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(null) forControlEvents:UIControlEventTouchUpInside];//Add selector
    [bbds addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(6, 182, 82, 30)];
    [btnLeft setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(dismissViewBailBondDetail) forControlEvents:UIControlEventTouchUpInside];
    [bbds addSubview:btnRight];
    
    [self.view addSubview:bbds];
    
    if(![txtFullName.text isEqualToString:@""] && ![txtAddress.text isEqualToString:@""]&& ![txtPhone.text isEqualToString:@""] && ![txtSecondaryPhone.text isEqualToString:@""] && ![txtEmail.text isEqualToString:@""]){
        [self evaluateBailBonds];
    }
}


-(void)addSearchName{
    [self addSearch:@"Search by Name"];
}

-(void)addSearchZip{
    [self addSearch:@"Search by Zip"];
}
-(void)addSearch:(NSString *)searchType{
    isZipClicked = YES;
    search = [[UIView alloc] initWithFrame:CGRectMake(68, 182, 273, 79)];
    
    search.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 263, 21)];
    lblTitle.text = searchType;
    [search addSubview:lblTitle];
    
    UITextField *txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(5, 41, 263, 30)];
    txtSearch.backgroundColor = [UIColor blackColor];
    txtSearch.layer.cornerRadius = 10;
    txtSearch.textColor = [UIColor whiteColor];
    txtSearch.placeholder = @"Search zip code";
    [txtSearch setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtSearch.textAlignment = NSTextAlignmentCenter;
    //txtSearch.placeholder = @"Type search here";
    [search addSubview:txtSearch];

    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(7, 77, 82, 30)];
    [btnLeft setTitle:@"Submit" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(null) forControlEvents:UIControlEventTouchUpInside];//add sumbit
    [search addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(95, 77, 82, 30)];
    [btnLeft setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(dismissViewSearch) forControlEvents:UIControlEventTouchUpInside];
    [bbds addSubview:btnRight];

    [self.view addSubview:search];
}

-(void)dismissViewSearch
{
    [search removeFromSuperview];
}

-(void)dismissViewBailBondDetail
{
    [bbds removeFromSuperview];
}

//-(BOOL)zipClicked
//{
//    BOOL isZipClicked;
//    if(isZipClicked == YES)
//    {
//        //[search removeFromSuperview];
//        isZipClicked = NO;
//    }
//    
//    else
//    {
//        //[self addSearchZip];
//        isZipClicked = YES;
//    }
//    
//    return isZipClicked;
//}

@end
