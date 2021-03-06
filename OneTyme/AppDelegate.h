//
//  AppDelegate.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/27/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/* ////////////Should it be attorney:istDataArray or is there something dealing with attoneryListData??
 ///For now, I will create attoneryDataArray
@property (strong, nonatomic) NSMutableArray *attorneyListData;
@property (strong, nonatomic) NSMutableArray *BailBondsListData;*/

@property (strong, nonatomic) NSMutableArray *AttorneyDataArray;
@property (strong, nonatomic) NSMutableArray *BailBondsDataArray;

@property (nonatomic,retain) NSMutableArray *LifeLineDataArray;
@property (nonatomic,retain) NSMutableDictionary *addLifeLineDict;
@property (nonatomic,retain) NSMutableDictionary *editLifeLineDict;
@property (nonatomic,retain) NSString *plistPath;

- (CALayer *)gradientBGLayerForBounds:(CGRect)bounds;

@end

