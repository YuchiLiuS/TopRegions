//
//  Place.h
//  TopPlaces
//
//  Created by yuchiliu on 11/17/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo, Region;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * placeId;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) Region *whichRegion;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
