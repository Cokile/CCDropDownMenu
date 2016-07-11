//
//  ViewController.m
//  CCDropDownMenu
//
//  Created by Kelvin on 7/8/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ViewController.h"
#import "CCDropDownMenus.h"

@interface ViewController () <CCDropDownMenuDelegate>

@property (nonatomic, strong) ManaDropDownMenu *menu1;
@property (nonatomic, strong) ManaDropDownMenu *menu2;
@property (nonatomic, strong) SyuDropDownMenu *menu3;
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.861 green:0.8599 blue:0.8538 alpha:1.0];
    
    CGRect frame = CGRectMake((CGRectGetWidth(self.view.frame)-240)/2, 240, 240, 37);
    
    self.menu1 = [[ManaDropDownMenu alloc] initWithFrame:frame title:@"Choose a weather"];
    self.menu1.delegate = self;
    self.menu1.numberOfRows = 3;
    self.menu1.textOfRows = @[@"Facebook", @"Twitter", @"Weibo"];
    self.menu1.heightOfRows = 50;
    [self.view addSubview:self.menu1];
    
    self.menu2 = [[ManaDropDownMenu alloc] initWithFrame:CGRectOffset(frame, 0, 77) title:@"Choose a network"];
    self.menu2.delegate = self;
    self.menu2.gutter = 5;
    self.menu2.resilient = YES;
    self.menu2.numberOfRows = 4;
    self.menu2.imageNameOfRows = @[@"sun", @"cloud", @"rain", @"snow"];
    self.menu2.textOfRows = @[@"sun", @"cloud", @"rain", @"snow"];
    self.menu2.heightOfRows = 37;
    [self.view addSubview:self.menu2];
    
    self.menu3 = [[SyuDropDownMenu alloc] initWithNavigationBar:self.naviBar useNavigationController:NO];
    self.menu3.delegate = self;
    self.menu3.numberOfRows = 3;
    self.menu3.colorOfRows = @[[UIColor colorWithRed:0.2824 green:0.2824 blue:0.2863 alpha:1.0],
                               [UIColor colorWithRed:0.2824 green:0.2824 blue:0.2863 alpha:1.0],
                               [UIColor colorWithRed:0.2824 green:0.2824 blue:0.2863 alpha:1.0]];
    self.menu3.activeColor = [UIColor whiteColor];
    self.menu3.textOfRows = @[@"Inbox", @"Unread", @"Starred"];
    [self.view addSubview:self.menu3];
}

- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index {
    if (dropDownMenu == self.menu1 || dropDownMenu == self.menu2) {
        NSLog(@"%@", ((ManaDropDownMenu *)dropDownMenu).title);
    }
    
    if (dropDownMenu == self.menu3) {
        NSLog(@"%lu", (long)index);
    }
}

@end
