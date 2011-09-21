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

#define MODE_ObjectiveC (0)
#define MODE_GWT (1)

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
}
- (NSString * ) timeAssertText:(NSString * )time withLimit:(NSString * )timeLimitStr withMessage:(NSString * )message byType:(int)currentMode;

- (IBAction)languageTapped:(id)sender;

- (IBAction)timeDistanceUpdate:(id)sender;

@end
