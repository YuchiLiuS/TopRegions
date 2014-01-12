//
//  Photo.h
//  TopPlaces
//
//  Created by yuchiliu on 11/17/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer, Place, Region;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) Region *whichRegion;
@property (nonatomic, retain) Photographer *whoTook;
@property (nonatomic, retain) Place *whichPlace;

@end
