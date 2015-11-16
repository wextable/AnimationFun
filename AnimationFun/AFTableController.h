//
//  AFTableController.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/13/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFTableController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *constraintHeaderContentViewTop;

@end
