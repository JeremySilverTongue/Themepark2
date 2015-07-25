//
//  CameraTests.m
//  CameraTests
//
//  Created by Jeremy Silver on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraTests.h"

@implementation CameraTests

- (void)setUp
{
    [super setUp];
    camera = [[MyCamera alloc] init];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"Camera Position:%f",[[camera viewPosition] x]);
    
    
    
    STFail(@"Unit tests are not implemented yet in CameraTests");
}

@end
