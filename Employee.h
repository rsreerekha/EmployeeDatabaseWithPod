//
//  Employee.h
//  
//
//  Created by testadmin on 6/12/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department, Team;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber * uuID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) Department *departments;
@property (nonatomic, retain) Team *teams;

@end
