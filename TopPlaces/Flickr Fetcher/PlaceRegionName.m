//
//  PlaceRegionName.m
//  TopPlaces
//
//  Created by yuchiliu on 11/16/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "PlaceRegionName.h"
#import "FlickrFetcher.h"

@interface PlaceRegionName()
@property (nonatomic, strong) NSMutableDictionary *placeToRegion;
@end

@implementation PlaceRegionName

- (NSMutableDictionary*)placeToRegion
{
    if (!_placeToRegion) {
        _placeToRegion = [[NSMutableDictionary alloc] init];
    }
    return _placeToRegion;
}

- (NSString*)getRegionNamefromPlaceId:(id)placeID
{
    NSString *regionname = [self.placeToRegion objectForKey:placeID];
    if (!regionname) {
        NSURL *url = [FlickrFetcher URLforInformationAboutPlace:placeID];
        dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
        // put a block to do the fetch onto that queue
        dispatch_async(fetchQ, ^{
            // fetch the JSON data from Flickr
            NSData *jsonResults = [NSData dataWithContentsOfURL:url];
            // convert it to a Property List (NSArray and NSDictionary)
            NSDictionary *placeInformation = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                             options:0
                                                                               error:NULL];
            dispatch_
            regionname = [FlickrFetcher extractRegionNameFromPlaceInformation:placeInformation];

        });

    }
    return regionname;
}
+ (NSString *)regionnameForPlace:(id)placeId
{
    NSString *regionname = nil;
    
    return regionname;
}
@end
