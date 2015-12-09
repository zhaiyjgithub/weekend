//
//  animationObjcet.h
//  POPping
//
//  Created by chuck on 15-6-9.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface animationObjcet : NSObject <UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)id <UIViewControllerContextTransitioning>context;
@end
