//
//  GaiDropDownMenu.m
//  CCDropDownMenu
//
//  Created by Kelvin on 7/12/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "GaiDropDownMenu.h"

@interface GaiDropDownMenu () {
    CGFloat originalHeight;
    NSInteger originalIndex;
}

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) CALayer *seperatorLayer;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) NSMutableArray *listViews;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *borderLayer;

@end

@implementation GaiDropDownMenu

@synthesize seperatorColor = _seperatorColor;
@synthesize indicator  = _indicator;
@synthesize inactiveColor = _inactiveColor;
@synthesize title = _title;
@synthesize titleViewColor = _titleViewColor;

#pragma mark - Constants
static CGFloat const seperatorWidth = 1;

#pragma mark - Custom accessorys
- (void)setGutter:(CGFloat)gutter {
    if (gutter < 0) {
        _gutter = 0;
    } else {
        _gutter = gutter;
    }
}

-(void)setTitleViewColor:(UIColor *)titleViewColor {
    _titleViewColor = titleViewColor;
    self.titleView.backgroundColor = titleViewColor;
}

- (void)setSeperatorColor:(UIColor *)seperatorColor {
    _seperatorColor = seperatorColor;
    
    self.seperatorLayer.borderColor = seperatorColor.CGColor;
}

- (void)setIndicator:(UIImage *)indicator {
    _indicator = indicator;
    
    self.indicatorView.image = [indicator imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setInactiveColor:(UIColor *)inactiveColor {
    _inactiveColor = inactiveColor;
    
    self.titleLabel.textColor = inactiveColor;
    self.indicatorView.tintColor = inactiveColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (NSString *)title {
    return self.titleLabel.text;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInitialization];
        self.heightOfRows = CGRectGetHeight(self.frame);
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInitialization];
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    CGFloat length = CGRectGetHeight(self.bounds);
    originalHeight = length;
    
    self.titleView.frame = self.bounds;
    [self addSubview:self.titleView];
    
    self.titleLabel.frame = CGRectMake(8, 4, CGRectGetWidth(self.bounds)-length-8, length-8);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.titleView addSubview:self.titleLabel];
    
    self.indicatorView.frame = CGRectInset(CGRectMake(CGRectGetWidth(self.bounds)-length, 0, length, length), length*0.3, length*0.3);
    [self.titleView addSubview:self.indicatorView];
    
    CGRect frame = CGRectMake(CGRectGetWidth(self.bounds)-length-seperatorWidth, 0, seperatorWidth, length);
    self.seperatorLayer.frame = CGRectInset(frame, 0, length/6);
    [self.titleView.layer addSublayer:self.seperatorLayer];
    
    self.borderLayer.frame = CGRectMake(8, length-0.5, CGRectGetWidth(self.bounds)-16, 0.5);
    self.borderLayer.borderWidth = 0;
    [self.titleView.layer addSublayer:self.borderLayer];
    
    for (int i = 0; i < self.numberOfRows; i++) {
        CGRect frame = CGRectSetHeight(self.titleView.frame, self.heightOfRows);
        if (self.doesAppearFromOneSide || i%2 == 0) {
            frame = CGRectOffset(frame, -CGRectGetWidth(frame), CGRectGetHeight(self.titleView.frame)+i*self.heightOfRows+(i+1)*self.gutter);
        } else {
            frame = CGRectOffset(frame, CGRectGetWidth(frame), CGRectGetHeight(self.titleView.frame)+i*self.heightOfRows+(i+1)*self.gutter);
        }
        CCDropDownMenuCell *cell = [[CCDropDownMenuCell alloc] initWithFrame:frame];
        cell.alpha = 0;
        cell.index = i;
        cell.textAligment = NSTextAlignmentLeft;
        cell.activeColor = self.activeColor;
        cell.inactiveColor = self.inactiveColor;
        cell.text = [self.textOfRows objectAtIndex:i];
        cell.image = [UIImage imageNamed:[self.imageNameOfRows objectAtIndex:i]];
        cell.backgroundColor = [self.colorOfRows objectAtIndex:i]!=nil?[self.colorOfRows objectAtIndex:i]:self.titleViewColor;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cellBackgroundColorChanged" object:cell];
        
        [cell setNeedsDisplay];
        
        [self insertSubview:cell atIndex:0];
        [self.listViews addObject:cell];
    }
}

- (void)titleViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    self.isExpanded?[self animateForClose]:[self animateForExpansion];
    [self updateForColor:self.isExpanded?self.inactiveColor:self.activeColor];
    
    self.expanded = !self.isExpanded;
}

- (void)cellTapped:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSInteger index = [[userInfo objectForKey:@"index"] integerValue];
    CCDropDownMenuCell *cell = [userInfo objectForKey:@"cell"];
    
    if ([self.listViews containsObject:cell]) {
        self.expanded = NO;
        self.title = cell.text;
        
        [self animateForClose];
        [self updateForColor:self.inactiveColor];
        
        if ([self.delegate respondsToSelector:@selector(dropDownMenu:didSelectRowAtIndex:)]) {
            [self.delegate dropDownMenu:self didSelectRowAtIndex:index];
        }
    }
}

#pragma mark - Public methods
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [self initWithFrame:frame];
    
    if (self) {
        self.title = title;
    }
    
    return self;
}

#pragma mark - Private methods
- (void)commonInitialization {
    self.titleView = [[UIView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.seperatorLayer = [[CALayer alloc] init];
    self.borderLayer = [[CALayer alloc] init];
    self.indicatorView = [[UIImageView alloc] init];
    self.listViews = [NSMutableArray arrayWithCapacity:1];
    
    self.seperatorLayer.cornerRadius = CGRectGetWidth(self.seperatorLayer.frame)/2;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewTapped:)];
    [self.titleView addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellTapped:) name:@"CCDropDownMenuCellTapped" object:nil];
    
    self.activeColor = [UIColor colorWithRed:0.902 green:0.4196 blue:0.1255 alpha:1.0];
    self.inactiveColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    self.seperatorColor = [UIColor colorWithRed:0.8667 green:0.8667 blue:0.8667 alpha:1.0];
    self.borderLayer.borderColor = self.seperatorColor.CGColor;
    self.titleViewColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.indicator = [UIImage imageNamed:@"arrow.png"];
    
    self.seperatorLayer.borderWidth = seperatorWidth;
    self.gutter = 0.0;
    self.resilient = NO;
    self.appearFromOneSide = NO;
    self.heightOfRows = CGRectGetHeight(self.bounds);
}

- (void)updateForColor:(UIColor *)color {
    self.titleLabel.textColor = color;
    self.indicatorView.tintColor = color;
}

- (void)animateForExpansion {
    originalIndex = [self.superview.subviews indexOfObject:self];
    [self.superview bringSubviewToFront:self];
    
    NSInteger rows = self.numberOfRows;
    CGFloat height = self.heightOfRows;
    self.frame = CGRectSetHeight(self.frame, originalHeight+rows*(height+self.gutter));
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    for (CCDropDownMenuCell *cell in self.listViews) {
        NSInteger index = [self.listViews indexOfObject:cell];
        
        [UIView animateWithDuration:self.isResilient?0.6:0.35 delay:index*0.2 usingSpringWithDamping:self.isResilient?0.55:1 initialSpringVelocity:0 options:kNilOptions animations:^{
            cell.frame = CGRectSetX(cell.frame, 0);
            cell.alpha = 1;
            if (self.gutter == 0) {
                cell.borderWidth = 0.5;
                self.borderLayer.borderWidth = 0.5;
            }
        } completion:nil];
    }
}

- (void)animateForClose {
    for (CCDropDownMenuCell *cell in self.listViews) {        
        NSInteger index = [self.listViews indexOfObject:cell];
        
        [UIView animateWithDuration:0.3 delay:self.doesAppearFromOneSide?index*0.2:0 options:kNilOptions animations:^{
            cell.alpha = 0;
            
            CGRect frame = CGRectSetHeight(self.titleView.frame, self.heightOfRows);
            if (self.doesAppearFromOneSide || index%2 == 0) {
                frame = CGRectOffset(frame, -CGRectGetWidth(frame), CGRectGetHeight(self.titleView.frame)+index*self.heightOfRows+(index+1)*self.gutter);
            } else {
                frame = CGRectOffset(frame, CGRectGetWidth(frame), CGRectGetHeight(self.titleView.frame)+index*self.heightOfRows+(index+1)*self.gutter);
            }
            cell.frame = frame;
            
            if (self.gutter == 0) {
                cell.borderWidth = 0.0;
                self.borderLayer.borderWidth = 0.0;
            }
        } completion:nil];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.superview insertSubview:self atIndex:originalIndex];
        self.frame = CGRectSetHeight(self.frame, originalHeight);
    }];
}

@end
