//
//  Photographer+Create.m
//  TopPlaces
//
//  Created by yuchiliu on 11/15/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "Photographer+Create.h"

@implementation Photographer (Create)

+ (Photographer *)photographerWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = nil;
    
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else {
            if (![matches count]) {
                photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer"
                                                             inManagedObjectContext:context];
                photographer.name = name;
            } else {
                photographer = [matches lastObject];
            }
            
        }
    }
    
    return photographer;
}

@end
