//
//  TesttypeViewController.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MessengerSystem.h"

#import "TouchDetectionViewInterfaceObject.h"
#import "TabViewInterfaceObject.h"

@interface SmallControllViewController : NSViewController < NSTabViewDelegate >
{
    MessengerSystem * messenger;
    IBOutlet TouchDetectionViewInterfaceObject * touchView;
    
    IBOutlet NSTextFieldCell *nowTimeDescription;
    IBOutlet NSTextFieldCell *nowTimeDistance;
    IBOutlet NSTextFieldCell *justCopiedText;
    IBOutlet NSButton *languageCell;
    
    IBOutlet NSTextFieldCell *timeAssertTextBase;
    
    IBOutlet NSButtonCell *timeDistanceButton;
    
    IBOutlet TabViewInterfaceObject *tabViewIntObj;
    NSDictionary * languageDict;
    
    
    
    
    //live setting
    NSColor * originalNowTimeDescriptionColor;
    NSFont * originalNowTimeDescriptionFont;
    NSRect originalNowTimeDescriptionFrame;
    
    NSColor * originalNowTimeDistanceColor;
    NSFont * originalNowTimeDistanceFont;
    NSRect originalNowTimeDistanceFrame;

    NSColor * originalTimeAssertTextBaseColor;
    NSFont * originalTimeAssertTextBaseFont;
    NSRect originalTimeAssertTextBaseFrame;
}
- (NSString * ) timeAssertText:(NSString * )time withLimit:(NSString * )timeLimitStr withMessage:(NSString * )message byType:(int)currentMode;

- (IBAction)languageTapped:(id)sender;

- (IBAction)timeDistanceUpdate:(id)sender;

- (void) resetInterfaceCondition;

@end
