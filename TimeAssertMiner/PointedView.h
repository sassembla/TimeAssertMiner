//
//  PointedView.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/21.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PointedView : NSView
{
    NSPoint startPoint;
}

- (void) updatePoints:(NSPoint)start;

@end
