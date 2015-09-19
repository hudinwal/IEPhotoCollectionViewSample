//
//  IECacher.m
//  DetailPageDemo
//
//  Created by Dinesh Kumar on 15/09/15.
//  Copyright (c) 2015 Dinesh Kumar. All rights reserved.
//

#import "IECacher.h"

static NSTimeInterval expirationInterval =  (double)86400;

@implementation IECacher

+ (void) resetCache {
    [[NSFileManager defaultManager] removeItemAtPath:[IECacher cacheDirectory] error:nil];
}

+ (NSString*) cacheDirectory {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths firstObject];
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"IECaches"];
    return cacheDirectory;
}

+ (NSData*) cachedDataForKey:(NSString *)key {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename])
    {
        NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
        if ([modificationDate timeIntervalSinceNow] > expirationInterval) {
            [fileManager removeItemAtPath:filename error:nil];
        } else {
            NSData *data = [NSData dataWithContentsOfFile:filename];
            return data;
        }
    }
    return nil;
}

+ (void) cacheData:(NSData *)data forKey:(NSString *)key {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];
    
    BOOL isDir = YES;
    if (![fileManager fileExistsAtPath:self.cacheDirectory isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:self.cacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    [data writeToFile:filename options:NSDataWritingAtomic error:nil];
}


@end
