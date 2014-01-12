//
//  TopRegionsAppDelegate+MD.m
//  TopPlaces
//
//  Created by yuchiliu on 11/15/13.
//  Copyright (c) 2013 CS193P. All rights reserved.
//

#import "TopRegionsAppDelegate+MD.h"

@implementation TopRegionsAppDelegate (MD)
- (NSManagedObjectContext *)createUIManagedDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                     inDomains:NSUserDomainMask] firstObject];
    NSString *documentName = @"MyDocument";
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    __block BOOL docSuccess = NO;
    if([fileManager fileExistsAtPath:[url path]]){
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Success");
                docSuccess = YES;
            }
            else {
                NSLog(@"couldn't open document at %@", url);
            }
        }];
    }else {
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success){
              if (success) {
                  NSLog(@"Success");
                  docSuccess = YES;
              }
              if (!success) {
                  NSLog(@"couldn't create document at %@",url);
              }
          }];
    }
//    NSManagedObjectContext *context = nil;
    NSManagedObjectContext *context = document.managedObjectContext;
    return context;
}

@end
