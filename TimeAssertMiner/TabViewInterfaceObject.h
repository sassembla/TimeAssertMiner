//
//  TabViewInterfaceObject.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/22.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "MessengerSystem.h"

@interface TabViewInterfaceObject : NSTabView
{
    MessengerSystem * messenger;
}
- (void) setUp;
@end
