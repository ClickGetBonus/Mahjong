//
//  UIScrollView+GQScrollView.m
//  GQ24
//
//  Created by admin on 2016/11/4.
//  Copyright © 2016年 condenast. All rights reserved.
//

#import "UIScrollView+GQScrollView.h"

@implementation UIScrollView (GQScrollView)

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ( !self.dragging )
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if ( !self.dragging )
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    } 
}

@end
