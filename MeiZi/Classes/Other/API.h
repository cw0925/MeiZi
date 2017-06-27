//
//  API.h
//  MeiZi
//
//  Created by afarsoft on 2017/6/27.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#ifndef API_h
#define API_h
/**NSLOG*/
#if DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif
/**屏幕参数*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ViewWidth  self.view.frame.size.width
#define ViewHeight self.view.frame.size.height
/**Color(有参数)*/
#define RGBColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
/**PushController*/
#define PushController(controller) [self.navigationController pushViewController:controller animated:YES];
/**API*/
#define HomeURL @"http://127.0.0.1:5000/info"

#endif /* API_h */
