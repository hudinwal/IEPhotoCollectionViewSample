//
//  IECacher.h
//  DetailPageDemo
//
//  Created by Dinesh Kumar on 15/09/15.
//  Copyright (c) 2015 Dinesh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IECacher : NSObject

+ (void) resetCache;

+ (NSData*) cachedDataForKey:(NSString*)key;
+ (void)cacheData:(NSData*)data forKey:(NSString*)key;

@end
