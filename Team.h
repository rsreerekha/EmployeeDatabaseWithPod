//
//  Team.h
//  
//
//  Created by testadmin on 6/12/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department, Employee;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * teamname;
@property (nonatomic, retain) NSNumber * hasOpenPositions;
@property (nonatomic, retain) Department *departments;
@property (nonatomic, retain) NSSet *employees;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)values;
- (void)removeEmployees:(NSSet *)values;

@end
