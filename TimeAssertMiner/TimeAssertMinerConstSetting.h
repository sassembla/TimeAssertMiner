//
//  TimeAssertMinerConstSetting.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

enum LANGUAGES {
    OBJECTIVE_C = 0,
    GWT,
    JUSTIME,
    NUM_OF_LANGUAGE  
};


#define T0_0        (0)             //0
#define T1_30       (60*30)         //30m
#define T2_1H       (60*60)         //1h
#define T3_4H       (60*60*4)       //4h
#define T4_1D       (60*60*24)      //1d
#define T5_2D       (60*60*24*2)    //2d
#define T6_10D      (60*60*24*10)   //10d
#define NUM_OF_TIMES    (7)


#define MASTER_DELEGATE     (@"MASTER_DELEGATE")
#define VIEW_CONT           (@"VIEW_CONT")
#define VIEW                (@"VIEW")
#define SLIDER_CONT         (@"SLIDER_CONT")
#define POINTEDWINDW_CONT   (@"POINTEDWINDW_CONT")
#define TABVIEW             (@"TABVIEW")
