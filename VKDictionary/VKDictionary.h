//
//  VKDictionary.h
//  VKDictionary
//
//  Created by Vladyslav Korneyev on 12/14/15.
//  Copyright © 2015 Vladyslav Korneyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKDictionary : NSObject

// Initialization section. Return a dictionary object.
- (instancetype)init;
- (instancetype)initWithCapacity:(NSUInteger)numItems;

// Return count of key/value pairs in dictionary.
- (int)count;

// Return object for key in dictionary (Array of objects for objectsForKeys: method).
- (id)objectForKey:(id)aKey;
- (NSArray *)objectsForKeys:(NSArray *)aKeys;

// Return all keys for objects in dictionary.
- (NSArray *)getAllKeys;

// Store an object (anObject) in initialized dictionary for key (aKey).
- (void)setObject:(id)anObject forKey:(id)aKey;

// Remove section. Remove stored object by key (aKey). To remove all objects use removeAllObjects method.
- (void)removeObjectForKey:(id)aKey;
- (void)removeAllObjects;

@end
