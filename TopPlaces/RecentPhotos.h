//
//  RecentPhotos.h
//  TopPlaces
//
//  Created by yuchiliu on 11/3/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject

+ (void)addPhoto: (NSDictionary*)photo;
+ (NSArray*) recentPhotos;
@end
