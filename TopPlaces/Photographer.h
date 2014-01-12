//
//  Photographer.h
//  TopPlaces
//
//  Created by yuchiliu on 11/17/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo, Region;

@interface Photographer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) NSSet *whichRegions;
@end

@interface Photographer (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

- (void)addWhichRegionsObject:(Region *)value;
- (void)removeWhichRegionsObject:(Region *)value;
- (void)addWhichRegions:(NSSet *)values;
- (void)removeWhichRegions:(NSSet *)values;

@end
