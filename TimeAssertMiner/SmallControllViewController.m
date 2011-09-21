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

int currentLanguage = 0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        messenger = [[MessengerSystem alloc]initWithBodyID:self withSelector:@selector(receiver:) withName:VIEW_CONT];
        [messenger inputParent:MASTER_DELEGATE];
        
        [messenger callMyself:@"repeat",nil];
        languageDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                        @"Objective-C", [NSString stringWithFormat:@"%d", OBJECTIVE_C],
                        @"GWT", [NSString stringWithFormat:@"%d", GWT],
                        nil];
    }
    
    return self;
}
- (void) loadView {
    [super loadView];
    languageCell.title = [languageDict valueForKey:[NSString stringWithFormat:@"%d", currentLanguage]];
    [tabViewIntObj setUp];
}

- (void) receiver:(NSNotification * )notif {
    NSString * exec = [messenger getExecFromNortification:notif];
    NSDictionary * dict = [messenger getTagValueDictionaryFromNotification:notif];
    
   
    if ([exec isEqualToString:@"pasteToBoard"]) {
        
        [justCopiedText setTextColor:[NSColor colorWithSRGBRed:0.25 green:0.25 blue:0.25 alpha:0.8]];
        
        NSString * message = @"";//空欄
        NSString * pasteMessage = [self timeAssertText:[TimeMine localizedTime] withLimit:nowTimeDistance.title withMessage:message byType:currentLanguage];
        
        
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
         [messenger withDelay:0.9],
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
    
    if ([exec isEqualToString:@"languageChanged"]) {
        [self timeAssertText:@"" withLimit:@"" withMessage:@"" byType:currentLanguage];
    }
    
    if ([exec isEqualToString:@"lineStarted"] || [exec isEqualToString:@"lineDragged"]) {
        [messenger callParent:@"lineStarted", 
         [messenger tag:@"startPoint" val:[dict valueForKey:@"startPoint"]],
         [messenger tag:@"endPoint" val:[dict valueForKey:@"endPoint"]],
         nil];
    }
   
    if ([exec isEqualToString:@"lineDropped"]) {
        
        NSString * message = @"";//空欄
        NSString * pasteMessage = [self timeAssertText:[TimeMine localizedTime] withLimit:nowTimeDistance.title withMessage:message byType:currentLanguage];
        
        [messenger call:VIEW withExec:@"drop",
         [messenger tag:@"message" val:pasteMessage],
         nil];
        
        
        [messenger callParent:@"lineDropped",
         nil];
    }
}


- (NSString * ) timeAssertText:(NSString * )time withLimit:(NSString * )timeLimitStr withMessage:(NSString * )message byType:(int)currentMode {
    switch (currentMode) {
        case MODE_ObjectiveC:{
            [[nowTimeDescription controlView] setFrame:CGRectMake(187, 48, [[nowTimeDescription controlView] frame].size.width, [[nowTimeDescription controlView] frame].size.height)];
            [[nowTimeDistance controlView] setFrame:CGRectMake(185, 34, [[nowTimeDistance controlView] frame].size.width, [[nowTimeDistance controlView] frame].size.height)];
            
            timeAssertTextBase.title = @"[TimeMine \n    setTimeMineLocalizedFormat:\n                             withLimitSec:\n                           withComment:@\"\"\n];";
            
            return [NSString stringWithFormat:@"[TimeMine setTimeMineLocalizedFormat:@\"%@\" withLimitSec:%@ withComment:@\"%@\"];//%@", 
                    time, 
                    timeLimitStr, 
                    message, 
                    [MessengerIDGenerator getMID]];
        }
            
        case MODE_GWT:{
            [[nowTimeDescription controlView] setFrame:CGRectMake(50, 48, [[nowTimeDescription controlView] frame].size.width, [[nowTimeDescription controlView] frame].size.height)];
            [[nowTimeDistance controlView] setFrame:CGRectMake(50, 34, [[nowTimeDistance controlView] frame].size.width, [[nowTimeDistance controlView] frame].size.height)];
            
            
            int num = (int)[nowTimeDistance.title length];
            NSMutableString * addSpace = [[NSMutableString alloc]init];
            
            for (int i = 0; i < num; i++) {
                [addSpace appendString:@"  "];
            }
            timeAssertTextBase.title = [NSString stringWithFormat:@"debug.timeAssert(\n                                          ,\n           %@,\n           \"\"\n);", addSpace];
            
            return [NSString stringWithFormat:@"debug.timeAssert(\"%@\", %@, \"%@\");//%@", 
                    time, 
                    timeLimitStr, 
                    message, 
                    [MessengerIDGenerator getMID]];
        }
            
        default:
            return nil;
    }
}

int timeCount = 0;
- (IBAction)timeDistanceUpdate:(id)sender {
    timeCount = (timeCount+1)%7;
    
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
    
    [timeDistanceButton setTitle:[NSString stringWithFormat:@"%d, %dmin, %dhour, %dday", time, time/60, time/(60*60), time/(60*60*24)]];
    [nowTimeDistance setIntValue:time];
}

- (IBAction)languageTapped:(id)sender {
    currentLanguage = (currentLanguage+1)%NUM_OF_LANGUAGE;
    
    languageCell.title = [languageDict valueForKey:[NSString stringWithFormat:@"%d", currentLanguage]];
    [messenger callMyself:@"languageChanged", nil];
}




- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    [TimeMine setTimeMineLocalizedFormat:@"11/09/22 02:00:44" withLimitSec:0 withComment:@"選択が発生したらサーチへ"];//DB4C51C7-629A-4761-B634-FBF214697618
}




@end
