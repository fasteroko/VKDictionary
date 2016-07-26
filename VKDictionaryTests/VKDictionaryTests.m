//
//  VKDictionaryTests.m
//  VKDictionaryTests
//
//  Created by Vladyslav Korneyev on 12/14/15.
//  Copyright © 2015 Vladyslav Korneyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VKDictionary.h"

@interface DictionaryTests : XCTestCase

@end

@implementation DictionaryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetObjectForKey{
    VKDictionary *dict = [VKDictionary new];
    
    [dict setObject:@"Jack" forKey:@(11)];
    [dict setObject:@"Jill" forKey:@(15)];
    [dict setObject:@(20) forKey:@"Age"];
    [dict setObject:@(170) forKey:@"Height"];
    
    XCTAssertTrue([[dict objectForKey:@(11)] isEqualToString:@"Jack"]);
    XCTAssertNil([dict objectForKey:@"bla bla bla"]);
    
}

- (void)testRemoveAllObjects {
    VKDictionary *dict = [VKDictionary new];
    
    [dict setObject:@"Jack" forKey:@(11)];
    [dict setObject:@"Jill" forKey:@(15)];
    [dict setObject:@(20) forKey:@"Age"];
    [dict setObject:@(170) forKey:@"Height"];
    
    [dict removeAllObjects];
    
    XCTAssertNil([dict objectForKey:@"Age"]);
}

- (void)testRemoveObjectForKey {
    VKDictionary *dict = [VKDictionary new];
    
    [dict setObject:@"Jack" forKey:@(11)];
    [dict setObject:@"Jill" forKey:@(15)];
    [dict setObject:@(20) forKey:@"Age"];
    [dict setObject:@(170) forKey:@"Height"];
    
    [dict removeObjectForKey:@"Height"];
    
    XCTAssertNil([dict objectForKey:@"Height"]);
}

- (void)testCount {
    VKDictionary *dict = [VKDictionary new];
    
    [dict setObject:@"Jack" forKey:@(11)];
    [dict setObject:@"Jill" forKey:@(15)];
    [dict setObject:@(20) forKey:@"Age"];
    [dict setObject:@(170) forKey:@"Height"];
    
    XCTAssertEqual([dict count], 4);
}

- (void)testObjectForKey{
    VKDictionary *dict = [VKDictionary new];
    
    [dict setObject:@"Jack" forKey:@(11)];
    [dict setObject:@"Jill" forKey:@(15)];
    [dict setObject:@(20) forKey:@"Age"];
    [dict setObject:@(170) forKey:@"Height"];
    
    XCTAssertEqual([dict objectForKey:@"Age"], @20);
    
}

- (void)testObjectsForKeys{
    VKDictionary *dict = [[VKDictionary alloc] init];
    
    [dict setObject:@"Jack" forKey:@"One"];
    [dict setObject:@"Jill" forKey:@"Two"];
    [dict setObject:@"Bill" forKey:@"Three"];
    [dict setObject:@"Alex" forKey:@"Four"];
    [dict setObject:@"Vlad" forKey:@"Five"];
    [dict setObject:@"Max" forKey:@"Six"];
    
    NSArray *arr = [dict getAllKeys];
    NSArray *array = [NSArray arrayWithObjects:
                      @"One", @"Two", @"Three", @"Ten", @"Five", @"Six", nil];
    
    XCTAssertNotNil([dict objectsForKeys:arr]);
    XCTAssertThrows([dict objectsForKeys:array]);
}

- (void)testGetAllKeys {
    VKDictionary *dict = [[VKDictionary alloc] init];
    
    [dict setObject:@"Jack" forKey:@"One"];
    [dict setObject:@"Jill" forKey:@"Two"];
    [dict setObject:@"Bill" forKey:@"Three"];
    [dict setObject:@"Alex" forKey:@"Four"];
    [dict setObject:@"Vlad" forKey:@"Five"];
    [dict setObject:@"Max" forKey:@"Six"];
    
    XCTAssertNotNil([dict getAllKeys]);
    NSArray *array = [NSArray arrayWithObjects:
                      @"One", @"Two", @"Three", @"Four", @"Five", @"Six", nil];
    XCTAssertEqualObjects([dict getAllKeys],array);
}

@end
