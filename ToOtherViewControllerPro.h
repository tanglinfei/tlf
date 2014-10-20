//
//  ToOtherViewControllerPro.h
//  LoveEnvironmennt
//
//  Created by  on 14-9-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol  GoToOtherControllerDelegate <NSObject>
-(void) gotoController:(NSURL*)url;
@end