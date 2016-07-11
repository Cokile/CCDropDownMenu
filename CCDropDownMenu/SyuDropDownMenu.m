//
//  SyuDropDownMenu.m
//  CCDropDownMenu
//
//  Created by Kelvin on 7/11/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "SyuDropDownMenu.h"

@interface SyuDropDownMenu () {
    CGFloat originalHeight;
    NSInteger originalIndex;
}

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) CALayer *seperatorLayer;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) NSMutableArray *listViews;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *borderLayer;
@property (nonatomic, strong) UINavigationBar *navigationBar;


@end

@implementation SyuDropDownMenu

@synthesize indicator  = _indicator;
@synthesize inactiveColor = _inactiveColor;

#pragma mark - Custom accessorys
- (void)setGutter:(CGFloat)gutter {
    if (gutter < 0) {
        _gutter = 0;
    } else {
        _gutter = gutter;
    }
}

- (void)setIndicator:(UIImage *)indicator {
    _indicator = indicator;
    
    self.indicatorView.image = [indicator imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setInactiveColor:(UIColor *)inactiveColor {
    _inactiveColor = inactiveColor;
    
    self.indicatorView.tintColor = inactiveColor;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInitialization];
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
    
    self.indicatorView.frame = CGRectInset(CGRectMake((CGRectGetWidth(self.titleView.frame)-length)/2, 0, length, length), 0, 0);
    [self.titleView addSubview:self.indicatorView];
    
    self.borderLayer.frame = CGRectMake(8, length-0.5, CGRectGetWidth(self.bounds)-16, 0.5);
    self.borderLayer.borderWidth = 0;
    [self.titleView.layer addSublayer:self.borderLayer];
    
    for (int i = 0; i < self.numberOfRows; i++) {
        CCDropDownMenuCell *cell = [[CCDropDownMenuCell alloc] initWithFrame:self.titleView.bounds];
        cell.index = i;
        cell.textAligment = NSTextAlignmentCenter;
        cell.activeColor = self.activeColor;
        cell.inactiveColor = self.inactiveColor;
        cell.text = [self.textOfRows objectAtIndex:i];
        cell.backgroundColor = [self.colorOfRows objectAtIndex:i]?[self.colorOfRows objectAtIndex:i]:self.titleView.backgroundColor;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cellBackgroundColorChanged" object:cell];
        
        [cell setNeedsDisplay];
        
        [self insertSubview:cell atIndex:0];
        [self.listViews addObject:cell];
    }
}

- (void)titleViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    self.isExpanded?[self animateForClose]:[self animateForExpansion];
    
    self.expanded = !self.isExpanded;
}

- (void)cellTapped:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSInteger index = [[userInfo objectForKey:@"index"] integerValue];
    CCDropDownMenuCell *cell = [userInfo objectForKey:@"cell"];
    
    if ([self.listViews containsObject:cell]) {
        self.expanded = NO;
        self.navigationBar.topItem.title = cell.text;
        
        [self animateForClose];
        
        
        if ([self.delegate respondsToSelector:@selector(dropDownMenu:didSelectRowAtIndex:)]) {
            [self.delegate dropDownMenu:self didSelectRowAtIndex:index];
        }
    }
}

#pragma mark - Public methods
- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar useNavigationController:(BOOL)doesUseNavigationCOntroller {
    [navigationBar setTranslucent:NO];
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[[UIImage alloc] init]];
    [navigationBar setTitleVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
    
    CGFloat originY = doesUseNavigationCOntroller?0:CGRectGetHeight(navigationBar.frame);
    self = [self initWithFrame:CGRectMake(0, originY, CGRectGetWidth([UIScreen mainScreen].bounds), 10)];
    
    if (self) {
        self.titleView.backgroundColor = navigationBar.barTintColor;
        self.navigationBar = navigationBar;
    }
    
    return self;
}

#pragma mark - Private methods
- (void)commonInitialization {
    self.titleView = [[UIView alloc] init];
    self.borderLayer = [[CALayer alloc] init];
    self.indicatorView = [[UIImageView alloc] init];
    self.listViews = [NSMutableArray arrayWithCapacity:1];
    self.navigationBar = [[UINavigationBar alloc] init];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewTapped:)];
    [self.titleView addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellTapped:) name:@"CCDropDownMenuCellTapped" object:nil];
    
    self.activeColor = [UIColor colorWithRed:0.8261 green:0.85 blue:0.8682 alpha:1.0];
    self.inactiveColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    self.borderLayer.borderColor = [UIColor colorWithRed:0.8667 green:0.8667 blue:0.8667 alpha:1.0].CGColor;
    self.titleViewColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.indicator = [UIImage imageNamed:@"arrow.png"];
    
    self.gutter = 0.0;
    self.resilient = NO;
    self.heightOfRows = 37;
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
        [UIView animateWithDuration:self.isResilient?0.6:0.35 delay:0 usingSpringWithDamping:self.isResilient?0.55:1 initialSpringVelocity:0 options:kNilOptions animations:^{
            cell.frame = CGRectSetHeight(cell.frame, height);
            [cell setNeedsDisplay];
            cell.frame = CGRectOffset(cell.frame, 0, CGRectGetHeight(self.titleView.frame)+index*height+(index+1)*self.gutter);
            
            if (self.gutter == 0) {
                cell.borderWidth = 0.5;
                self.borderLayer.borderWidth = 0.5;
            }
        } completion:nil];
    }
}

- (void)animateForClose {
    for (CCDropDownMenuCell *cell in self.listViews) {
        [cell removeAllSubviews];
        
        [UIView animateWithDuration:0.25 animations:^{
            cell.frame = self.titleView.bounds;
            
            if (self.gutter == 0) {
                cell.borderWidth = 0.0;
                self.borderLayer.borderWidth = 0.0;
            }
        }];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.superview insertSubview:self atIndex:originalIndex];
        self.frame = CGRectSetHeight(self.frame, originalHeight);
    }];
}

@end

