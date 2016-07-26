//
//  VKDictionary.m
//  VKDictionary
//
//  Created by Vladyslav Korneyev on 12/14/15.
//  Copyright © 2015 Vladyslav Korneyev. All rights reserved.
//

#import "VKDictionary.h"

const int initial_capacity = 16;

struct Key {
    void *_name;
    void *_address;
};

@implementation VKDictionary {
    struct Key *_keysArray;
    
    int _count;
    NSUInteger _capacity;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _count = 0;
        _capacity = initial_capacity;

        _keysArray = malloc(sizeof(struct Key) * _capacity);
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        _count = 0;
        _capacity = numItems;

        _keysArray = malloc(sizeof(struct Key) * _capacity);
    }
    return self;
}

- (int)count {
    return _count;
}

- (id)objectForKey:(id)aKey {
    for (int i = 0; i < _count; i++) {
        
        if (sizeof(aKey) == sizeof(_keysArray[i]._name)) {
            
            void *instanceOne = _keysArray[i]._name;
            void *instanceTwo = (__bridge void *)(aKey);
            
            int checkingSize = sizeof(_keysArray[i]._name);
            int compareResult = memcmp(&instanceOne, &instanceTwo, checkingSize);
            
            if (compareResult == 0) {
                void *requestedObject = _keysArray[i]._address;
                return (__bridge id)(requestedObject);
            }
        }
    }
    
    return NULL;
}

- (NSArray *)objectsForKeys:(NSArray *)aKeys {
    NSMutableArray *objectsArrayToReturn = [NSMutableArray array];
    
    for (id aKey in aKeys) {
        
        for (int i = 0; i < _count; i++) {
            
            if (sizeof(aKey) == sizeof(_keysArray[i]._name)) {
                
                void *instanceOne = _keysArray[i]._name;
                void *instanceTwo = (__bridge void *)(aKey);
                int checkingSize = sizeof(_keysArray[i]._name);
                
                int compareResult = memcmp(&instanceOne, &instanceTwo, checkingSize);
                
                if (compareResult == 0) {
                    void *requestedObject = _keysArray[i]._address;
                    [objectsArrayToReturn addObject:(__bridge id _Nonnull)(requestedObject)];
                    break;
                } else if (i == _count - 1) {
                    NSException* keyException = [NSException
                                                exceptionWithName:@"NSRangeException"
                                                reason:[NSString stringWithFormat:@"*** -[__NSDictionaryM objectsForKeys:]: key %@ is not exist!", aKey]
                                                userInfo:nil];
                    @throw keyException;
                }
            }
        }
    }
    
    return objectsArrayToReturn;
}

- (NSArray *)getAllKeys {
    NSMutableArray *keysArrayToReturn = [NSMutableArray array];
 
    for (int i = 0; i < _count; i++) {
        [keysArrayToReturn addObject:(__bridge id _Nonnull)(_keysArray[i]._name)];
    }
    
    return keysArrayToReturn;
}

- (void)setObject:(id)anObject forKey:(id)aKey {
    if (_count > _capacity) {
        _keysArray = realloc(_keysArray, sizeof (struct Key) * (_capacity + initial_capacity));
    }

    _keysArray[_count]._name = (__bridge void *)(aKey);
    _keysArray[_count]._address = (__bridge void *)(anObject);
    
    _count++;
}

- (void)removeObjectForKey:(id)aKey {
    for (int i = 0; i < _count; i++) {
        
        if (sizeof(aKey) == sizeof(_keysArray[i]._name)) {
            void *instanceOne = _keysArray[i]._name;
            void *instanceTwo = (__bridge void *)(aKey);
            
            int checkingSize = sizeof(_keysArray[i]._name);
            int compareResult = memcmp(&instanceOne, &instanceTwo, checkingSize);
            
            if (compareResult == 0) {
                void *target = _keysArray + i;
                void *source = _keysArray + i + 1;
                int value = (_count - i - 1) * sizeof(struct Key);
                
                _keysArray = memmove(target, source, value);
                
                _keysArray[_count - 1]._name = nil;
                _keysArray[_count - 1]._address = nil;
                
                _count--;
            }
        }
    }
}

- (void)removeAllObjects {
    memset(_keysArray, 0, sizeof(struct Key) * _count);
    
    _capacity = initial_capacity;
    
    _keysArray = realloc(_keysArray, sizeof (struct Key) * _capacity);
    _count = 0;
}

- (void)dealloc {
    free(_keysArray);
    
    NSLog(@"%@ object has been deleted", self);
}

@end
