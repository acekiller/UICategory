//
//  RegularExperssionTests.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+YMRTPattern.h"

@interface RegularExperssionTests : XCTestCase

@end

@implementation RegularExperssionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) testRegularExpression {
//    NSString *rexTestString = @"测试[你好么],欢迎。[Hello],测试内容[Welcome],哈哈[笑脸],难啊";
//    NSArray *rexResults = [rexTestString patternResultWithPattern:@"(\\[[a-zA-Z0-9]{0,}[\u4E00-\u9FA5]{0,}\\])"];
//    NSLog(@"%@",rexResults);
}

@end
