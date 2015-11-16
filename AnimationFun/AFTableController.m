//
//  AFTableController.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/13/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFTableController.h"
#import "AFProgressiveBlurView.h"

@interface AFTableController ()
@property (nonatomic, strong) IBOutlet UIView *headerContentView;
@property (nonatomic, strong) IBOutlet AFProgressiveBlurView *blurView;
@end

@implementation AFTableController


-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"The Hotness";

    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    
    UIImage *imageToBlur = [UIImage imageNamed:@"heroes_wide"];
    __weak typeof(self) wself = self;
    [self.blurView processBlurWithMaxRadius:10.0
                                 inputImage:imageToBlur
                                    quality:AFProgressiveBlurViewQualityMedium competion:^{
                                        //sweet
                                        wself.blurView.blurriness = 1.0;
                                    }];

}


#pragma mark - UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    self.constraintHeaderContentViewTop.constant = offsetY;
    
    
    if (offsetY < 0) {
        CGFloat maxDelta = 100;
        self.blurView.blurriness = 1.0 - (-offsetY / maxDelta);
    } else {
        self.blurView.blurriness = 1.0;
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}


@end
