//
//  MessengerIDGenerator.h
//  TestKitTesting
//
//  Created by Inoue 徹 on 10/09/15.
//  Copyright 2010 KISSAKI. All rights reserved.
//

/**
 MIDを発行するクラス
 特に貯蓄とかはしていない事を明示するために
 クラスメソッドが一つあるのみ。
 */

#import <Foundation/Foundation.h>


@interface MessengerIDGenerator : NSObject {

}
+ (NSString * ) getMID;
@end
