//
//  RecentPhotos.m
//  TopPlaces
//
//  Created by yuchiliu on 11/3/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "RecentPhotos.h"

@implementation RecentPhotos

#define NUMOFPHOTOS 20
#define RECENTPHOTOKEY @"recent_photos_key"
+ (NSArray*) recentPhotos
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:RECENTPHOTOKEY];
}

+ (void)addPhoto:(NSDictionary *)photo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recentViewPhotos = [[defaults objectForKey:RECENTPHOTOKEY] mutableCopy];
    if (!recentViewPhotos) {
        recentViewPhotos = [[NSMutableArray alloc] init];
    }
    if (![recentViewPhotos containsObject:photo]) {
        [recentViewPhotos addObject:photo];
    }
    
    if ([recentViewPhotos count]>20) {
        [recentViewPhotos removeObjectAtIndex:0];
    }
    
    [defaults setObject:recentViewPhotos forKey:RECENTPHOTOKEY];
    [defaults synchronize];
}
@end
