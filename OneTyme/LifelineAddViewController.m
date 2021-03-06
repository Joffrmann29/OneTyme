//
//  LifelineAddViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#define kOFFSET_FOR_KEYBOARD 65.0
#import "LifelineAddViewController.h"
#import "AppDelegate.h"

@interface LifelineAddViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *addressField;
@property (nonatomic, strong) UITextField *cityField;
@property (nonatomic, strong) UITextField *stateField;
@property (nonatomic, strong) UITextField *zipField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *emailField;

@end

@implementation LifelineAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *oneTymeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttorneyBackground.png"]];
    oneTymeImage.frame = CGRectMake(0, 64, self.view.frame.size.width, 663);
    [self.view addSubview:oneTymeImage];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"Save Lifeline" forState:UIControlStateNormal];
    [saveButton addTarget:self
                                action:@selector(saveLifeLine)
                      forControlEvents:UIControlEventTouchUpInside];
    saveButton.frame = CGRectMake(120.5, 621, 173, 29);
    CALayer *saveLayer = saveButton.layer;
    saveLayer = [self gradientBGLayerForBounds:saveButton.bounds];
    saveLayer.cornerRadius = 10;
    [self.view addSubview:saveButton];
    
    UIGraphicsBeginImageContext(saveLayer.bounds.size);
    [saveLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *saveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (saveImage != nil)
    {
        [saveButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }

    UIColor *textfieldPlaceholderColor = [UIColor lightGrayColor];

    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(57, 128, 300, 30)];
    self.nameField.layer.cornerRadius = 10;
    self.nameField.backgroundColor = [UIColor blackColor];
    self.nameField.textColor = textfieldPlaceholderColor;
    self.nameField.placeholder = @"Name";
    
    self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(57, 193, 300, 30)];
    self.addressField.layer.cornerRadius = 10;
    self.addressField.backgroundColor = [UIColor blackColor];
    self.addressField.textColor = textfieldPlaceholderColor;
    self.addressField.placeholder = @"Address";
    
    self.cityField = [[UITextField alloc]initWithFrame:CGRectMake(57, 258, 300, 30)];
    self.cityField.layer.cornerRadius = 10;
    self.cityField.backgroundColor = [UIColor blackColor];
    self.cityField.textColor = textfieldPlaceholderColor;
    self.cityField.placeholder = @"City";
    
    self.stateField = [[UITextField alloc]initWithFrame:CGRectMake(57, 323, 300, 30)];
    self.stateField.layer.cornerRadius = 10;
    self.stateField.backgroundColor = [UIColor blackColor];
    self.stateField.textColor = textfieldPlaceholderColor;
    self.stateField.placeholder = @"State";
    
    self.zipField = [[UITextField alloc]initWithFrame:CGRectMake(57, 398, 300, 30)];
    self.zipField.layer.cornerRadius = 10;
    self.zipField.backgroundColor = [UIColor blackColor];
    self.zipField.textColor = textfieldPlaceholderColor;
    self.zipField.placeholder = @"Zip Code";
    
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(57, 463, 300, 30)];
    self.phoneField.layer.cornerRadius = 10;
    self.phoneField.backgroundColor = [UIColor blackColor];
    self.phoneField.textColor = textfieldPlaceholderColor;
    self.phoneField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.phoneField.placeholder = @"Phone";
    
    self.emailField = [[UITextField alloc]initWithFrame:CGRectMake(57, 528, 300, 30)];
    self.emailField.layer.cornerRadius = 10;
    self.emailField.backgroundColor = [UIColor blackColor];
    self.emailField.textColor = textfieldPlaceholderColor;
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.placeholder = @"E-mail";

    [self.nameField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.addressField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.cityField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.stateField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.zipField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.emailField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    self.nameField.textAlignment = NSTextAlignmentCenter;
    self.addressField.textAlignment = NSTextAlignmentCenter;
    self.cityField.textAlignment = NSTextAlignmentCenter;
    self.stateField.textAlignment = NSTextAlignmentCenter;
    self.zipField.textAlignment = NSTextAlignmentCenter;
    self.phoneField.textAlignment = NSTextAlignmentCenter;
    self.emailField.textAlignment = NSTextAlignmentCenter;
    
    self.nameField.delegate = self;
    self.addressField.delegate = self;
    self.cityField.delegate = self;
    self.stateField.delegate = self;
    self.zipField.delegate = self;
    self.phoneField.delegate = self;
    self.emailField.delegate = self;
    
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.addressField];
    [self.view addSubview:self.cityField];
    [self.view addSubview:self.stateField];
    [self.view addSubview:self.zipField];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.emailField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self setViewMovedUp:NO];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidChange
{
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


-(void)saveLifeLine
{
    [self.delegate didAddLifeline:[self returnNewLifeline]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Life line save succesfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 99;
    [alert show];
}

-(LifeLine *)returnNewLifeline
{
    LifeLine *lifelineObject = [[LifeLine alloc] init];
    lifelineObject.name = self.nameField.text;
    lifelineObject.address= self.addressField.text;
    lifelineObject.city = self.cityField.text;
    lifelineObject.state = self.stateField.text;
    lifelineObject.zipCode = self.zipField.text;
    lifelineObject.phone = self.phoneField.text;
    lifelineObject.email = self.emailField.text;
    
    return lifelineObject;
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

- (IBAction)showContacts:(id)sender {
    [self showPeoplePickerController];
}

#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.
-(void)showPeoplePickerController
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    picker.topViewController.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    // Display only a person's phone, email, and birthdate
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
    
    picker.displayedProperties = displayedItems;
    // Show the picker
    [self presentViewController:picker animated:YES completion:nil];
    self.nameField.text = nil;
    self.addressField.text = nil;
    self.cityField.text = nil;
    self.stateField.text = nil;
    self.zipField.text = nil;
    self.phoneField.text = nil;
    self.emailField.text = nil;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person;
{
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *firstname = (__bridge  NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastname= (__bridge  NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    
    self.nameField.text = [NSString stringWithFormat:@"%@ %@",firstname,lastname];
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //self.phoneTextField.text = (NSString *)ABMultiValueCopyValueAtIndex(phone, 0);
    
    ABMultiValueRef aMulti = ABRecordCopyValue(person, kABPersonAddressProperty);
    if (aMulti != nil) {
        int aMultiCount = ABMultiValueGetCount(aMulti);
        for (int i = 0; i < aMultiCount; ++i) {
            NSDictionary *abDict = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(aMulti, i);
            
            self.addressField.text = [abDict objectForKey:(NSString *)kABPersonAddressStreetKey];
            self.cityField.text = [abDict objectForKey:(NSString *)kABPersonAddressCityKey];
            self.stateField.text = [abDict objectForKey:(NSString *)kABPersonAddressStateKey];
            self.zipField.text = [abDict objectForKey:(NSString *)kABPersonAddressZIPKey];
        }
        CFRelease(aMulti);
    }
    
    ABMultiValueRef emailMultiValue = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSArray *emailAddresses = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailMultiValue);
    //CFRelease(emailMultiValue);
    
    if([emailAddresses count]>0)
    {
        self.emailField.text = [emailAddresses objectAtIndex:0];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return YES;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}


// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
