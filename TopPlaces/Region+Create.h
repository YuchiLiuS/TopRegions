//
//  Region+Create.h
//  TopPlaces
//
//  Created by yuchiliu on 11/15/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "Region.h"

@interface Region (Create)

+ (Region *)regionWithName:(NSString *)name
     inManageObjectContext:(NSManagedObjectContext *)context;

@end
