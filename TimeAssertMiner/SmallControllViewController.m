//
//  TesttypeViewController.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "SmallControllViewController.h"
#import "TimeAssertMinerConstSetting.h"

#import "MessengerIDGenerator.h"

#import "TimeMine.h"

@implementation SmallControllViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        messenger = [[MessengerSystem alloc]initWithBodyID:self withSelector:@selector(receiver:) withName:VIEW_CONT];
        [messenger inputParent:MASTER_DELEGATE];
        
        [messenger callMyself:@"repeat",nil];
    }
    
    return self;
}


- (void) receiver:(NSNotification * )notif {
    NSString * exec = [messenger getExecFromNortification:notif];
    
    if ([exec isEqualToString:@"pasteToBoard"]) {
        
        [messenger callMyself:@"getModeThenPaste",nil];
    }
    
    
    
    if ([exec isEqualToString:@"getModeThenPaste"]) {
        [justCopiedText setTextColor:[NSColor colorWithSRGBRed:0.25 green:0.25 blue:0.25 alpha:0.8]];
        
        NSString * message = @"";//空欄
        NSString * pasteMessage = [self timeAssertText:[TimeMine localizedTime] withLimit:nowTimeDistance.title withMessage:message byType:0];
        
        
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        [pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:self];
        [pasteboard setString:pasteMessage forType:NSPasteboardTypeString];
        
        [messenger callMyself:@"fade",
         [messenger withDelay:0.01],
         nil];

    }
    
    if ([exec isEqualToString:@"fade"]) {
        [justCopiedText setTextColor:[NSColor colorWithSRGBRed:0.25 green:0.25 blue:0.25 alpha:1.0]];
        [messenger callMyself:@"fadeDuration",
         [messenger withDelay:0.7],
         nil];
    }
    
    if ([exec isEqualToString:@"fadeDuration"]) {
        NSColor * color = justCopiedText.textColor;
        float alpha = [color alphaComponent]/1.2;
        
        if (alpha < 0.001) alpha = 0;
        
        [justCopiedText setTextColor:[NSColor colorWithSRGBRed:0.25 green:0.25 blue:0.25 alpha:alpha]];
        
        if (0 < alpha) {
            [messenger callMyself:@"fadeDuration",
             [messenger withDelay:0.01],
             nil];
        }
    }
    
    if ([exec isEqualToString:@"repeat"]) {
        
        nowTimeDescription.title = [TimeMine localizedTime];
        
        [messenger callMyself:@"repeat",
         [messenger withDelay:0.1], nil];
    }
    
    if ([exec isEqualToString:@"uped"]) {
        [messenger callMyself:@"pasteToBoard", nil];
    }
}


- (NSString * ) timeAssertText:(NSString * )time withLimit:(NSString * )timeLimitStr withMessage:(NSString * )message byType:(int)currentMode {
    switch (currentMode) {
        case MODE_ObjectiveC:
            return [NSString stringWithFormat:@"[TimeMine setTimeMineLocalizedFormat:@\"%@\" withLimitSec:%@ withComment:@\"%@\"];//%@", 
                    time, 
                    timeLimitStr, 
                    message, 
                    [MessengerIDGenerator getMID]];

            
        case MODE_GWT:
            return [NSString stringWithFormat:@"debug.timeAssert(\"%@\", %@, \"%@\");//%@", 
                    time, 
                    timeLimitStr, 
                    message, 
                    [MessengerIDGenerator getMID]];

            
        default:
            return nil;
    }
}


- (IBAction)ClockIndicator:(id)sender {
    NSSlider * senderNSSlider = sender;
    int timeCount = [senderNSSlider intValue];
    
    int time = 0;
    
    /*
     どんな段階が欲しいか考える
     数を少なく、よく使うものだけを残す。細かいのは要らない。
    */
    switch (timeCount) {
        case 0:
            time = 0;
            break;
        
        case 1:
            time = 60*30;//30m
            break;
            
        case 2:
            time = 60*60;//1h
            break;
                        
        case 3:
            time = 60*60*4;//4h
            break;
                        
        case 4:
            time = 60*60*24;//1d
            break;
            
        case 5: 
            time = 60*60*24*2;//2d
            break; 
        
        case 6:
            time = 60*60*24*10;//10d
            break;        
        
        default:
            break;
    }
    
    [TimeText setTitle:[NSString stringWithFormat:@"%d, %dmin, %dhour, %dday", time, time/60, time/(60*60), time/(60*60*24)]];
    [nowTimeDistance setIntValue:time];
}



@end
