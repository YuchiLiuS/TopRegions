//
//  RecentFlickrPhotosTVC.h
//  TopPlaces
//
//  Created by yuchiliu on 11/3/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "FlickrPhotosTVC.h"

@interface RecentFlickrPhotosTVC : FlickrPhotosTVC
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
