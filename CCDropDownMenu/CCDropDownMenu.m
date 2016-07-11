//
//  CCDropDownMenu.m
//  CCDropDownMenu
//
//  Created by Kelvin on 7/8/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCDropDownMenu.h"

@interface CCDropDownMenu ()
 
@end

@implementation CCDropDownMenu

#pragma mark - Custom accessorys
- (void)setIndicator:(UIImage *)indicator {
    _indicator = [indicator imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

#pragma mark - Lifecycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.expanded = NO;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.expanded = NO;
    }
    
    return self;
}

#pragma mark - Public methods
- (void)cellTapped:(NSNotification *)notification {
    NSAssert(NO, @"%@ must be overridden.", NSStringFromSelector(_cmd));
}

@end
