//
//  Department.h
//  
//
//  Created by testadmin on 6/12/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee, Team;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * departmentname;
@property (nonatomic, retain) NSSet *employees;
@property (nonatomic, retain) NSSet *teams;
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)values;
- (void)removeEmployees:(NSSet *)values;

- (void)addTeamsObject:(Team *)value;
- (void)removeTeamsObject:(Team *)value;
- (void)addTeams:(NSSet *)values;
- (void)removeTeams:(NSSet *)values;

@end
