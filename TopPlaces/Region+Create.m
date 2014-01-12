//
//  Region+Create.m
//  TopPlaces
//
//  Created by yuchiliu on 11/15/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "Region+Create.h"

@implementation Region (Create)
+ (Region *)regionWithName:(NSString *)name
     inManageObjectContext:(NSManagedObjectContext *)context
{
    Region *region = nil;
    if ([name length]){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Region"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] >1)) {
            //error
        } else if(![matches count]){
            region = [NSEntityDescription insertNewObjectForEntityForName:@"Region" inManagedObjectContext:context];
            region.name = name;
        } else {
            region = [matches lastObject];
        }
    }
    
    return region;
}
@end
