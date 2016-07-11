//
//  SyuDropDownMenu.h
//  CCDropDownMenu
//
//  Created by Kelvin on 7/11/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCDropDownMenu.h"

@interface SyuDropDownMenu : CCDropDownMenu

#pragma mark - Public properties
/**
 *  The value that applys to the gutter distance between list view. Default value is 0.
 */
@property (nonatomic) CGFloat gutter;

/**
 *  The boolean value that indicates the weahter apply a resilient when expansion. Default value is NO.
 */
@property (nonatomic, getter=isResilient) BOOL resilient;

#pragma mark - Public methods
- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar useNavigationController:(BOOL)doesUseNavigationCOntroller;

@end
