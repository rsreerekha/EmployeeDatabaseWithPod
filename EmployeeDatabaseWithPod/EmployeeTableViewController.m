//
//  EmployeeTableViewController.m
//  EmployeeDatabaseWithPod
//
//  Created by testadmin on 6/12/15.
//  Copyright (c) 2015 testadmin. All rights reserved.
//

#import "EmployeeTableViewController.h"
#import "EmployeeViewController.h"
#import "Employee.h"
#import "Department.h"
#import "Team.h"
#import "EmployeeTableViewCell.h"
#import "AppDelegate.h"
@interface EmployeeTableViewController ()

@property NSMutableArray  *employeeArray;
@property BOOL shouldSortAscending;

@end
static NSString *const EMPLOYEE_NAME = @"name";
static NSString *const EMPLOYEE_UUID = @"uuID";
static NSString *const EMPLOYEE_SALARY = @"salary";

@implementation EmployeeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //self.employeeArray= [NSMutableArray arrayWithObjects:ryan,justin, steve, antoine, nil];
    
    //Employee *listOfname = [[Employee alloc]init];
    
    //self.names = [NSMutableArray arrayWithObject:listOfname.name];
   // NSLog(@"list of name:%@",self.names);
    
   //self.names =[NSArray  arrayWithObjects:ryan.name, justin.name, steve.name, antoine.name, nil];
    
    
  }

-(void)viewWillAppear:(BOOL)animated{
    NSMutableArray  *emps = [[Employee MR_findAll]mutableCopy];
    self.employeeArray = emps;
    [self.tableView reloadData];
    
    [self.employeeFiredLabel setHidden:YES ];
        
        //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:PREFERENCE_KEY_MR_HAS_DATA];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.employeeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* EmployeeCell = @"EmployeeCell";
    EmployeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EmployeeCell forIndexPath:indexPath];
    cell.employeeNamelabel.text = ((Employee *)(self.employeeArray[indexPath.row])).name;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Employee *firedEmployee = [self.employeeArray objectAtIndex:indexPath.row];
        [firedEmployee MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.employeeArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        if (self.employeeArray.count == 0)
        {
            [self.employeeFiredLabel setHidden:NO];
            self.employeeFiredLabel.text = @ "You’ve fired all your employees!";
        }
    }
}
- (void) fetchAllEmployess {
    self.employeeArray = [[Employee MR_findAll]mutableCopy];
    [self.tableView reloadData];
}





- (void) searchEmployees {
    NSString *searchQuery = self.searchBar.text;
    
    NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
    
    NSString *sortBy = [userPreferences valueForKey:@"searching_Key"];
    if( [sortBy isEqualToString:@"0"])
    {
        self.employeeArray = [[Employee
                       MR_findAllSortedBy:EMPLOYEE_NAME
                       ascending:YES
                       withPredicate:[NSPredicate predicateWithFormat:@"name contains[c] %@", searchQuery] inContext:[NSManagedObjectContext MR_defaultContext]]mutableCopy];
         }
    
    else if([sortBy isEqualToString:@"1"]){
        self.employeeArray = [[Employee
                               MR_findAllSortedBy:EMPLOYEE_UUID
                               ascending:YES
                               withPredicate:[NSPredicate predicateWithFormat:@"uuid == %@", searchQuery] inContext:[NSManagedObjectContext MR_defaultContext]]mutableCopy];
        
    }
    
    else if([sortBy isEqualToString:@"2"]){
        
        
        self.employeeArray = [[Employee
                               MR_findAllSortedBy:EMPLOYEE_UUID
                               ascending:YES
                               withPredicate:[NSPredicate predicateWithFormat:@"salary >= %@", searchQuery] inContext:[NSManagedObjectContext MR_defaultContext]]mutableCopy];
    }
    
 
    [self.tableView reloadData];
}








#pragma mark - Search Bar Delegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([self.searchBar.text length] > 0)
        [self searchEmployees];
    else
        [self fetchAllEmployess];
}




- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = YES;
    
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    self.searchBar.text = @"";
    self.searchBar.showsCancelButton = NO;
    [self fetchAllEmployess];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
    [self searchEmployees];
}










/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    static NSString *EDIT_EMPLOYEE_SEGUE = @"EmployeeDetails";
    
    static NSString *ADD_EMPLOYEE_SEGUE = @"AddEmployee";
    
    EmployeeViewController *detailviewController = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:EDIT_EMPLOYEE_SEGUE]) {

        //detailviewController.nametitlevariable = self.names[self.tableView.indexPathForSelectedRow.row];
        
        NSInteger row = [self.tableView indexPathForSelectedRow].row;
        
        Employee *selectedEmployee = [self.employeeArray objectAtIndex:row];
        
        detailviewController .employee = selectedEmployee;
    }
   else if ([[segue identifier] isEqualToString:ADD_EMPLOYEE_SEGUE]) {
    detailviewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                                 style:(UIBarButtonItemStyle)UIBarButtonSystemItemCancel
                                                                                                target:detailviewController
                                                                                                action:@selector(cancelAdd)];
        detailviewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                                  style:(UIBarButtonItemStyle)UIBarButtonSystemItemCancel
                                                                                                 target:detailviewController
                                                                                                 action:@selector(addNewEmployee)];
    }

        
        
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
