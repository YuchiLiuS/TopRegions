//
//  Place+Create.h
//  TopPlaces
//
//  Created by yuchiliu on 11/16/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "Place.h"

@interface Place (Create)
+ (Place*)placeWithId:(NSString *)placeId
inManagedObjectContext:(NSManagedObjectContext *)context;
@end
