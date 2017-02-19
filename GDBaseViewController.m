//
//  GDBaseViewController.m
//  Marvel
//
//  Created by aiuar on 13.02.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "GDBaseViewController.h"

@interface GDBaseViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation GDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(self.view.center.x - 25.f, self.view.center.y - 25.f, 50.f, 50.f); //[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.tableView.frame))];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [self.view addSubview: self.activityIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateActivityIndicator:(BOOL)animate {
    self.activityIndicator.hidden = !animate;
    if (animate) {
        [self.view bringSubviewToFront:self.activityIndicator];
        [self.activityIndicator startAnimating];
    }
    else
        [self.activityIndicator stopAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
