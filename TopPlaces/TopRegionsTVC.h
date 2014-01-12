//
//  TopPlacesTVC.h
//  TopPlaces
//
//  Created by yuchiliu on 11/3/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface TopRegionsTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
