//
//  Photo+Flickr.m
//  TopPlaces
//
//  Created by yuchiliu on 11/15/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photographer+Create.h"
#import "Region+Create.h"
#import "Place+Create.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    NSString *unique = photoDictionary[FLICKR_PHOTO_ID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || ([matches count] > 1)) {
        // handle error
    } else if ([matches count]) {
        photo = [matches firstObject];
    } else {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                              inManagedObjectContext:context];
        NSString *placeid = [photoDictionary valueForKey:FLICKR_PLACE_ID];
        NSString *photographerName = [photoDictionary valueForKeyPath:FLICKR_PHOTO_OWNER];
        photo.whoTook = [Photographer photographerWithName:photographerName inManagedObjectContext:context];
        photo.unique = unique;
        photo.title = [photoDictionary valueForKeyPath:FLICKR_PHOTO_TITLE];
        photo.subtitle = [photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.imageURL = [[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        photo.thumbnailURL = [[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatSquare] absoluteString];
        photo.whichPlace = [Place placeWithId:placeid inManagedObjectContext:context];
    }
    return photo;
}

+ (void)loadPhotosFromFlickrArray:(NSArray *)photos // of Flickr NSDictionary
         intoManagedObjectContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *photo in photos) {
        [self photoWithFlickrInfo:photo inManagedObjectContext:context];
    }
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.predicate = [NSPredicate predicateWithFormat:@"whichRegion = nil"];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if (!matches || error) {
        // handle error
    } else{
        dispatch_queue_t fetchQ = dispatch_queue_create("Flickr fetcher", NULL);
        // put a block to do the fetch onto that queue
        dispatch_async(fetchQ, ^{
            for (Place *place in matches){
                // NSLog(@"Fetching Region Info");
                // fetch the JSON data from Flickr
                NSURL *url = [FlickrFetcher URLforInformationAboutPlace:place.placeId];
                NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                // convert it to a Property List (NSArray and NSDictionary)
                NSDictionary *placeInformation = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                                 options:0
                                                                                   error:NULL];
                NSString *regionname = [FlickrFetcher extractRegionNameFromPlaceInformation:placeInformation];
                dispatch_async(dispatch_get_main_queue(),^(){
                    [context performBlock:^{
                        place.whichRegion = [Region regionWithName:regionname inManageObjectContext:context];
                        for (Photo *photo in place.photos) {
                            photo.whichRegion = place.whichRegion;
                            if (![photo.whoTook.whichRegions containsObject:photo.whichRegion]) {
                                int value = [photo.whichRegion.numofPhotographer intValue];
                                photo.whichRegion.numofPhotographer=[NSNumber numberWithInt:value + 1];
                                [photo.whoTook addWhichRegionsObject:photo.whichRegion];
                            }
                        }
                    }];
                });
            }
        });
    }
}

@end
