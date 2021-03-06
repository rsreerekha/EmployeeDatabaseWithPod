//
//  AppDelegate.m
//  EmployeeDatabaseWithPod
//
//  Created by testadmin on 6/12/15.
//  Copyright (c) 2015 testadmin. All rights reserved.
//

#import "AppDelegate.h"
#import "Employee.h"
#import "Team.h"
#import "Department.h"
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()

@end


static NSString *const PREFERENCE_KEY_MR_HAS_DATA = @"PREFERENCE_HAS_DATA_NAME";


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model"];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:PREFERENCE_KEY_MR_HAS_DATA]) {
        
        Employee *ryan = [Employee MR_createEntity];
        ryan.name  = @"Ryan Taylor";
        ryan.uuID = @919345446;
        ryan.departments = [Department MR_createEntity];
        ryan.departments.departmentname = @"Mobile Application Development";
        ryan.salary = @65000;
        ryan.teams = [Team MR_createEntity ];
        ryan.teams.teamname = @"Developers";
    
        Employee *justin = [Employee MR_createEntity];
        justin.name  = @"Justin Vernon";
        justin.uuID = @919644543;
        justin.departments = [Department MR_createEntity];
        justin.departments.departmentname = @"Performing Arts";
        justin.salary = @75000;
        justin.teams = [Team MR_createEntity];
        justin.teams.teamname = @"Mid-level";
    
    
        Employee *steve = [Employee MR_createEntity];
        steve.name  = @"Steve Brule";
        steve.uuID = @919582348;
        steve.departments = [Department MR_createEntity];
        steve.departments.departmentname = @"Clinical";
        steve.salary = @65000;
        steve.teams = [Team MR_createEntity];
        steve.teams.teamname = @"Nurse";
    
    
        Employee *antoine = [Employee MR_createEntity];
        antoine.name  = @"Antoine de Saint-Exupery";
        antoine.uuID = @9190084582;
        antoine.departments = [Department MR_createEntity];
        antoine.departments.departmentname = @"Aviation";
        antoine.salary = @75000;
        antoine.teams = [Team MR_createEntity];
        antoine.teams.teamname = @" Test Engineers";
    
    
        [[NSManagedObjectContext MR_defaultContext]
         
         MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
             if (success)
                 NSLog(@"Successfully saved context 1");
             else
                 NSLog(@"Error saving context: %@", error.description);
         }];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PREFERENCE_KEY_MR_HAS_DATA];
        [[NSUserDefaults standardUserDefaults] synchronize];
        

    }
    
  

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
