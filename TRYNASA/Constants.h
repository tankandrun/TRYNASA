//
//  Constants.h
//  TRYNASA
//
//  Created by 金顺度 on 16/2/2.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define NAVGATIONBAR_HEIGHT 64
#define TABBAR_HEIGHT 49




#endif /* Constants_h */
