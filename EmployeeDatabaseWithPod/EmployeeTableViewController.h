//
//  EmployeeTableViewController.h
//  EmployeeDatabaseWithPod
//
//  Created by testadmin on 6/12/15.
//  Copyright (c) 2015 testadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *segmentControllButton;
@property (weak, nonatomic) IBOutlet UIButton *addEmployeeButton;
@property (weak, nonatomic) IBOutlet UILabel *employeeFiredLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
