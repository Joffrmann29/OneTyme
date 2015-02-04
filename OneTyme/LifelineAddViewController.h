//
//  LifelineAddViewController.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeLine.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@protocol LifelineAddViewControllerDelegate <NSObject>

-(void)didAddLifeline:(LifeLine *)lifeline;
<<<<<<< HEAD
-(void)didUpdateLifeline:(LifeLine *)lifeline;
=======
>>>>>>> dda2f1131eee80af04ea4b45c5588cb850f4a8ea

@end

@interface LifelineAddViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate>

-(IBAction)saveButton_Clicked:(id)sender;
-(IBAction)backButton_Clicked:(id)sender;
-(IBAction)selectFromContacts:(id)sender;

-(void)fillEditDetails;

-(void)saveLifeLine;
-(void)editLifeLine;

-(void)showPeoplePickerController;
- (IBAction)showContacts:(id)sender;

@property(nonatomic,readwrite) BOOL isEdit;
@property(nonatomic,readwrite) int editIndex;
/* A delegate property which will allow us to call the protocol methods. */
<<<<<<< HEAD
@property (weak, nonatomic) id <LifelineAddViewControllerDelegate> delegate;
@property (nonatomic, strong) LifeLine *lifeline;
=======
@property (retain, nonatomic) id <LifelineAddViewControllerDelegate> delegate;
>>>>>>> dda2f1131eee80af04ea4b45c5588cb850f4a8ea

@end
