//
//  EmployeeViewController.h
//  EmployeeDatabaseWithPod
//
//  Created by testadmin on 6/12/15.
//  Copyright (c) 2015 testadmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"
#import "Department.h"
#import "Team.h"

@interface EmployeeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *employeeNameTitle;
@property (weak, nonatomic) IBOutlet UITextField *employeeNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *idTextfield;

@property (weak, nonatomic) IBOutlet UITextField *departmentNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextfield;

@property (weak, nonatomic) IBOutlet UITextField *teamNameField;
@property Employee *employee;

-(void)cancelAdd;
- (void)addNewEmployee;
@end
