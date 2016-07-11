//
//  CCDropDownMenuCell.h
//  CCDropDownMenu
//
//  Created by Kelvin on 7/8/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDropDownMenuCell : UIView
#pragma mark - Public properties
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *activeColor;
@property (nonatomic, strong) UIColor *inactiveColor;
@property (nonatomic) NSUInteger index;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) NSTextAlignment textAligment;

#pragma mark - Public methods
- (void)removeAllSubviews;

@end
