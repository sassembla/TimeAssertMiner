//
//  PointedView.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/21.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "PointedView.h"

@implementation PointedView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        startPoint = CGPointMake(frame.origin.x, frame.origin.y);
        
        // Initialization code here.
    }
    
    return self;
}


- (void) updatePoints:(NSPoint)start {
    float size = 12.0;
    startPoint.x = start.x;
    startPoint.y = start.y-size/2.0;
    
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    float size = 12.0;
    NSPoint currentEndPoint = CGPointMake(self.superview.frame.size.width/2.0, self.superview.frame.size.height/2.0);
   
    //ライン
    NSBezierPath * path = [NSBezierPath bezierPath];
    [path setLineWidth: 4];
   
    
    [path moveToPoint:startPoint];
    [path lineToPoint:CGPointMake(currentEndPoint.x, currentEndPoint.y-size/2.0)];
    
    NSColor *lineBlue = [NSColor colorWithCalibratedRed:0.137f green:0.509f blue:0.792f alpha:1.0f];
    
    [lineBlue set];
    
    CGFloat lineDash[2];
	
	lineDash[0] = 5.0;
	lineDash[1] = 5.0;
    [path setLineDash:lineDash count:1.8 phase:0.01];
    [path stroke];

    
    
    //丸の元を作る(陰の為に必要)
    NSRect startOval = { currentEndPoint.x-size/2.0, currentEndPoint.y-size, size, size };
    NSBezierPath * startPointBall = [NSBezierPath bezierPathWithOvalInRect:startOval];
    [startPointBall setLineWidth:2.38];
    
    
    NSShadow *dropShadow = [[[NSShadow alloc] init] autorelease];
    [dropShadow setShadowColor:[NSColor blackColor]];
    [dropShadow setShadowBlurRadius:4];
    [dropShadow setShadowOffset:NSMakeSize(2,-2)];
    
    [NSGraphicsContext saveGraphicsState];
    [dropShadow set];
    
    
    NSColor *ballBlue = [NSColor colorWithCalibratedRed:0 green:0.439f blue:0.77f alpha:1.0f];
    
    [ballBlue set];
    [startPointBall fill];//中身と陰を描画
    [NSGraphicsContext restoreGraphicsState];
    
    //丸を表示
    NSColor * white = [NSColor whiteColor];
    [white set];[startPointBall stroke];
}

@end
