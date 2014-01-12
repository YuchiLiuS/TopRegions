//
//  Place+Create.m
//  TopPlaces
//
//  Created by yuchiliu on 11/16/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "Place+Create.h"
#import "FlickrFetcher.h"
#import "Region+Create.h"
@implementation Place (Create)
+ (Place*)placeWithId:(NSString *)placeId
inManagedObjectContext:(NSManagedObjectContext *)context;

{
    Place *place = nil;
    
    if ([placeId length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
        request.predicate = [NSPredicate predicateWithFormat:@"placeId = %@", placeId];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else {
            if (![matches count]) {
                place = [NSEntityDescription insertNewObjectForEntityForName:@"Place"
                                                             inManagedObjectContext:context];
                place.placeId = placeId;

            } else {
                place = [matches lastObject];
            }
            
        }
    }
    return place;
}
@end
