//
//  EmployeeViewController.m
//  EmployeeDatabaseWithPod
//
//  Created by testadmin on 6/12/15.
//  Copyright (c) 2015 testadmin. All rights reserved.
//

#import "EmployeeViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface EmployeeViewController ()

@end
static const int EMPLOYEE_NAME_FIELD_TAG = 0;
static const int EMPLOYEE_UUID_FIELD_TAG = 1;
static const int EMPLOYEE_DEPARTMENT_NAME_FIELD_TAG = 2;
static const int EMPLOYEE_SALARY_FIELD_TAG =3;
static const int EMPLOYEE_TEAM_FIELD_TAG = 4;


@implementation EmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.employee) {
        self.employee = [Employee MR_createEntity];
    }
    if (!self.employee.departments){
        self.employee.departments = [Department MR_createEntity];
    }
    if(!self.employee.teams){
        self.employee.teams = [Team MR_createEntity];
    }
    
    self.title = self.employee.name ? self.employee.name : @"New Employee";
    self.employeeNameTextfield .text = self.employee.name;
    self. idTextfield.text = [NSString stringWithFormat:@"%@", self.employee.uuID];
    self.departmentNameTextfield .text = self.employee.departments.departmentname;
    self.teamNameField.text = self.employee.teams.teamname;

    NSNumber* salary = self.employee.salary;
    
    
    self.salaryTextfield.text = [self formatSalary:salary];
    
    //[NSString stringWithFormat:@"%@", self.employee.salary];
    
    //self.employeeNameTitle.text = self.employee.name;
   // NSLog(@"yft :%@",self.employee.name);
    
    // Do any additional setup after loading the view.
}
- (void)cancelAdd {
    [self.employee MR_deleteEntity];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addNewEmployee {
    
    [self saveContext];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext]
     MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
         if (success)
             NSLog(@"Successfully saved context 2");
         else
             NSLog(@"Error saving context: %@", error.description);
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.employeeNameTextfield resignFirstResponder];
    [self.idTextfield resignFirstResponder];
    [self.departmentNameTextfield resignFirstResponder];
    [self saveContext];
}

#pragma mark TextField and TextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text length] > 0) {
        
        switch (textField.tag) {
            case EMPLOYEE_NAME_FIELD_TAG:
                self.title = textField.text;
                self.employee.name = textField.text;
                break;
            case EMPLOYEE_UUID_FIELD_TAG:
                self.employee.uuID = [NSNumber numberWithInteger:[textField.text integerValue]];
                break;
            case EMPLOYEE_DEPARTMENT_NAME_FIELD_TAG:
                self.employee.departments.departmentname = textField.text;
                break;
//            case EMPLOYEE_SALARY_FIELD_TAG:
//                
//                //self.employee.salary =[NSNumber numberWithInteger:[textField.text integerValue]];
//                break;
                
            case EMPLOYEE_TEAM_FIELD_TAG:
                
                self.employee.teams.teamname = textField.text;
                break;
                
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (textField.tag == EMPLOYEE_SALARY_FIELD_TAG  ) {
        
        
        // "string" gets the first value typed in the textfield and is assigned to newString.
        NSString *newString = [NSString stringWithString:string];
        
        
        NSMutableString *textFieldTextStr = [NSMutableString stringWithString:textField.text];
        
        [textFieldTextStr replaceCharactersInRange:range withString:newString];
        //moving the number towards left
        newString = [textFieldTextStr stringByReplacingOccurrencesOfString:@"$" withString:@""];
        newString = [newString stringByReplacingOccurrencesOfString:@"." withString:@""];
        newString = [newString stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        
        //taking the integer value.
        NSInteger newStringIntergerValue = newString.integerValue;
        //converting to NSNumber.
        NSNumber *salary = [[NSNumber alloc] initWithFloat:(float)newStringIntergerValue];
        self.employee.salary = salary;
        [self saveContext];
        
       // [self forwardingTargetForSelector:salary];
       /* NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [currencyFormatter setMaximumFractionDigits:0];
        [currencyFormatter setCurrencyCode:@"USD"];*/
       // [self formatSalary:salary];
        
        textField.text = [self formatSalary:salary];
        
        return NO;
    }
    
    return YES;
}


-(NSString*)formatSalary: (NSNumber*)salary{
    
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormatter setMaximumFractionDigits:0];
    [currencyFormatter setCurrencyCode:@"USD"];
    
    
    NSString *formattedSalary  = [currencyFormatter stringFromNumber:salary];
    return formattedSalary;
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
