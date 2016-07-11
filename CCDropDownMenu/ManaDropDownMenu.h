//
//  ManaDropDownMenu.h
//  CCDropDownMenu
//
//  Created by Kelvin on 7/9/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCDropDownMenu.h"

@interface ManaDropDownMenu : CCDropDownMenu

#pragma mark - Public properties
/**
 *  The color that applys to the seperator for the title and the indicator. Default value is a gray color.
 */
@property (nonatomic, strong) UIColor *seperatorColor;

/**
 *  The value that applys to the gutter distance between list view. Default value is 0.
 */
@property (nonatomic) CGFloat gutter;

/**
 *  The string that applys to the title of the menu.
 */
@property (nonatomic, strong) NSString *title;

/**
 *  The boolean value that indicates the weahter apply a resilient when expansion. Default value is NO.
 */
@property (nonatomic, getter=isResilient) BOOL resilient;

/**
 *  The strings that represent the name of the image for each row.
 */
@property (nonatomic, strong) NSArray <NSString *> *imageNameOfRows;

#pragma mark - Public methods
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
