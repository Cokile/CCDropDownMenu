//
//  CCDropDownMenu.h
//  CCDropDownMenu
//
//  Created by Kelvin on 7/8/16.
//  Copyright © 2016 Cokile. All rights reserved.
//
// CCDropDownMenu is the base class for all the drop menus.
// You should not use it directly.

#import <UIKit/UIKit.h>
#import "CCDropDownMenuCell.h"
#import "Rect.h"

@class CCDropDownMenu;

#pragma mark - delegate protocol
@protocol CCDropDownMenuDelegate <NSObject>

@optional
/**
 *  Tells the delegate that the specified row is now selected.
 *
 *  @param dropDownMenu A drop down menu object informing the delegate about the new row selection.
 *  @param index        An index locating the new selected row in dropDownMenu.
 */
- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index;

@end

@interface CCDropDownMenu : UIView

#pragma mark - Public properties
/**
 *  The object that acts as the delegate of the drop down menu.
 */
@property (nonatomic, weak) id <CCDropDownMenuDelegate> delegate;

/**
 *  The color that applys to the title and the arrow when the drop down menu is expanded. Default value is a orange color.
 */
@property (nonatomic, strong) UIColor *activeColor;

/**
 *  The color that applys to the title and the arrow when the drop down menu is closed. Default value is a gray color.
 */
@property (nonatomic, strong) UIColor *inactiveColor;

/**
 *  The color that applys to the title view. Default value is a white color.
 */
@property (nonatomic, strong) UIColor *titleViewColor;

/**
 *  The image that applys to the right indicator for the drop down menu. Default value is a arrow image.
 */
@property (nonatomic, strong) UIImage *indicator;

/**
 *  The boolean value that indicates if the drop down menu is expanded.
 */
@property (nonatomic, getter=isExpanded) BOOL expanded;

/**
 *  The value that applys to the number of rows of the drop down menu.
 */
@property (nonatomic) NSInteger numberOfRows;

/**
 *  The value that applys to the height for row of the drop down menu.
 */
@property (nonatomic)CGFloat heightOfRows;

/**
 *  THe strings that apply to the text for each row.
 */
@property (nonatomic, strong) NSArray <NSString *> *textOfRows;

/**
 *  The colors that applys to background color for each row.
 */
@property (nonatomic, strong) NSArray <UIColor *> *colorOfRows;

#pragma mark - Public methods
- (void)cellTapped:(NSNotification *)notification;

@end
