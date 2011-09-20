//
//  TimeMine.h
//  TimeMine
//
//  Created by Toru Inoue on 11/03/08.
//  Copyright 2011 KISSAKI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TimeMine : NSObject {

}

+ (NSTimeInterval) setTimeMine:(NSDate * )date withLimitSec:(NSTimeInterval)addLimitSec withComment:(NSString * )comment;
+ (NSTimeInterval) setTimeMineLocalizedFormat:(NSString * )dateString withLimitSec:(int)addLimitSec withComment:(NSString * )comment;

+ (NSString * ) time:(NSDate * )date;
+ (NSString * ) localizedTime;

@end
