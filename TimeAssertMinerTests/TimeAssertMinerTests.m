//
//  TimeAssertMinerTests.m
//  TimeAssertMinerTests
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "TimeAssertMinerTests.h"
#import "TimeMine.h"

@implementation TimeAssertMinerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTime
{
    NSString * time = [TimeMine time:[NSDate date]];
    STAssertEqualObjects([@"11/09/19 07:16:17" length], [time length], @"一緒ではない    %@", time);
}

- (void) testlocalizedTime {
    NSString * date = [TimeMine localizedTime];
     STAssertEqualObjects([@"11/09/19 07:16:17" length], [date length], @"一緒ではない    %@", date);
}

@end
