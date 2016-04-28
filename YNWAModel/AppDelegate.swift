//
//  AppDelegate.swift
//  YNWAModel
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        deleteData()
        populateCoreData()
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "fi.metropolia.YNWAModel" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("YNWAModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData2.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func populateCoreData() {
        
        // Companies
        let company = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company.name = "Metro"
        company.companyDescription = "placeholder"
        company.logoURL = "http://users.metropolia.fi/~thanhtra/Media_Labs/metro.jpg"
        company.companyURL = "http://www.metropolia.fi/"
        
        
        let company2 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company2.name = "Sport Inc."
        company2.companyDescription = "placeholder"
        company2.logoURL = "http://users.metropolia.fi/~thanhtra/Media_Labs/metro.jpg"
        
        let company3 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company3.name = "Kiasma"
        company3.companyDescription = "placeholder"
        company3.logoURL = "http://users.metropolia.fi/~thanhtra/Media_Labs/metro.jpg"

        let company4 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company4.name = "Construction Inc."
        company4.companyDescription = "placeholder"
        company4.logoURL = "http://users.metropolia.fi/~thanhtra/Media_Labs/background.jpg"

        let company5 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company5.name = "Football Pro Inc."
        company5.companyDescription = "placeholder"
        company5.logoURL = "http://users.metropolia.fi/~thanhtra/Media_Labs/background.jpg"

        let company6 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company6.name = "Pulse"
        company6.companyDescription = "placeholder"
        company6.logoURL = "http://users.metropolia.fi/~thanhtra/Media_Labs/background.jpg"
        company6.companyURL = "http://www.metropolia.fi/"

        
        // Employees
        let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee.name = "Alex"
        employee.company = company
        employee.position = "Tech Department Header"
        employee.profileURL = "http://users.metropolia.fi/~thanhtra/images/me.jpg"
        
    
        let employee2 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee2.name = "Mikael"
        employee2.company = company2
        employee2.position = "Road Man"
        employee2.profileURL = "http://users.metropolia.fi/~thanhtra/sad.gif"
        
        let employee3 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee3.name = "Juhani"
        employee3.company = company3
        employee3.position = "Developer"
        employee3.profileURL = "http://users.metropolia.fi/~thanhtra/sad.gif"
        
        let employee4 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee4.name = "Antti"
        employee4.company = company4
        employee4.position = "Developer"
        employee4.profileURL = "http://users.metropolia.fi/~thanhtra/images/me.jpg"
        
        let employee5 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee5.name = "Kevin"
        employee5.company = company5
        employee5.position = "Manager"
        employee5.profileURL = "http://users.metropolia.fi/~thanhtra/images/me.jpg"
        
        let employee6 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee6.name = "KH"
        employee6.company = company6
        employee6.position = "Tester"
        employee6.profileURL = "http://users.metropolia.fi/~thanhtra/sad.gif"
        
        
        // Beacons
        let beacon = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: managedObjectContext) as! Beacon
        beacon.major = "35"
        beacon.minor = "35"
        beacon.company = company
        beacon.employee = employee
        
        let beacon2 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: managedObjectContext) as! Beacon
        beacon2.major = "911"
        beacon2.minor = "912"
        beacon2.company = company2
        beacon2.employee = employee2
        
        let beacon3 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: managedObjectContext) as! Beacon
        beacon3.major = "57832"
        beacon3.minor = "7199"
        beacon3.company = company3
        beacon3.employee = employee3
        
        let beacon4 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: managedObjectContext) as! Beacon
        beacon4.major = "46880"
        beacon4.minor = "36104"
        beacon4.company = company4
        beacon4.employee = employee4
        
        let beacon5 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: managedObjectContext) as! Beacon
        
        beacon5.major = "42204"
        beacon5.minor = "15444"
        beacon5.company = company5
        beacon5.employee = employee5
        
        let beacon6 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: managedObjectContext) as! Beacon
        beacon6.major = "32127"
        beacon6.minor = "12136"
        beacon6.company = company6
        beacon6.employee = employee6
        
        
        
        saveContext()
    }
    
    func deleteData() {
        let fetchRequest = NSFetchRequest(entityName: "Beacon")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.executeRequest(deleteRequest, withContext: managedObjectContext)
        } catch let error as NSError {
            debugPrint(error)
        }
        saveContext()
    }
   
}

