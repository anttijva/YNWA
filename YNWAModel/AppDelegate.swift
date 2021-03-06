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
        company.name = "Metropolia University of Applied Sciences"
        company.companyDescription = "Helsinki Metropolia University of Applied Sciences is one of the most international universities of applied sciences in Finland. International activities at Metropolia include international degree programmes, student and teacher mobility, work placement opportunities abroad and various projects."
        company.logoURL = "https://exchange.edu.metropolia.fi/travelreports/images/MetropoliaLogoTopLeft.png"
        company.companyURL = "http://www.metropolia.fi/"
        
        
        let company2 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company2.name = "Sport Inc."
        company2.companyDescription = "We're an app to find and do fitness. We are committed to making getting out and doing fun fitness stuff easy and super transparent. We've originated in New York City and Helsinki, Finland (we know, right). If either of these locations are a good fit for you, get in touch with us. If not, do it anyway!SportSetter crew is an ambitious and skilful bunch."
        company2.logoURL = "http://blog.fitlyst.com/wp-content/uploads/2015/04/Sportsetter.png"
        company2.companyURL = "https://sportsetter.workable.com/"
        
        let company3 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company3.name = "Kiasma"
        company3.companyDescription = "Kiasma is a museum of contemporary art under the umbrella of the Finnish National Gallery. Its primary role is to educate the public on contemporary art and to strengthen the status of art in Finland in general. A lively cultural centre and meeting place, Kiasma is the place for pleasure and experience. The name derives from ‘chiasm’, which stands for an intersection, particularly the crossing of optic nerves."
        company3.logoURL = "http://www.hiap.fi/system/files/hiap_images/kiasma_logo_magenta.jpg"
        company3.companyURL = "http://www.kiasma.fi/en/kiasma/"

        let company4 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company4.name = "Movenium Oy"
        company4.companyDescription = "Movenium was established in 2005 and we have just celebrated our 10 year anniversary in 2015. Our aim is to provide the best possible service to our clients. We are confident that our solution can massively reduce the monthly working hours that each of the different level employees have, from the staff to the directors use for the time management process."
        company4.logoURL = "http://www.movenium.com/wp-content/uploads/2014/11/Movenium_vaaka.png"
        company4.companyURL = "http://www.movenium.com/en/about-us/"

        let company5 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company5.name = "Pro-Football Inc."
        company5.companyDescription = "Pro-Football, Inc., doing business as The Washington Redskins, operates a football club. Its categories include news, videos, photos, team, schedule, tickets, cheer, fedexfield, and shop. The company was founded in 1932 and is based in Ashburn, Virginia. Pro-Football, Inc. operates as a subsidiary of Washington Football, Inc."
        company5.logoURL = "http://www.lommen.com/wp-content/uploads/2014/07/Redskins-logo-200x-72dpi-300x80.jpg"
        company5.companyURL = "http://www.redskins.com"

        let company6 = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedObjectContext) as! Company
        company6.name = "Pulse"
        company6.companyDescription = "PULSE delivers high-quality, competitive transaction routing and settlement services for a variety of electronic payment products. This is achieved primarily through the operation of the network “switch.” The PULSE switch routes electronic messages between debit/ATM terminals, processors and card-issuing financial institutions. An authorization or denial is then returned to the terminal and the cardholder."
        company6.logoURL = "http://www.covchurch.org/wp-content/uploads/sites/2/2012/04/pulse-lockup.png"
        company6.companyURL = "https://www.pulsenetwork.com/"

        
        // Employees
        let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee.name = "Alex Lindroos"
        employee.company = company
        employee.position = "Tech Department Header"
        employee.profileURL = "https://scontent-arn2-1.xx.fbcdn.net/hphotos-xta1/v/t1.0-9/10846421_10202140410072047_799535652551650595_n.jpg?oh=8717f610cde8d2f7a2d968c6b159514b&oe=57AD2F2A"
        
    
        let employee2 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee2.name = "Mikael Gousetis"
        employee2.company = company2
        employee2.position = "Road Man"
        employee2.profileURL = "https://scontent-arn2-1.xx.fbcdn.net/hphotos-xpa1/v/t1.0-9/20989_10209011270626753_127441520039407267_n.jpg?oh=6c41d9cffbe1b25518bd4452eecff8e0&oe=579DB6D3"
        
        let employee3 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee3.name = "Juhani Lavonen"
        employee3.company = company3
        employee3.position = "Developer"
        employee3.profileURL = "https://scontent-arn2-1.xx.fbcdn.net/hphotos-xpl1/v/t1.0-9/11892162_127517454262258_4956090422152046590_n.jpg?oh=f75192c51723b6836cfd5fe4fb9dbd75&oe=57A4E1EC"
        
        let employee4 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee4.name = "Antti Valkonen"
        employee4.company = company4
        employee4.position = "Developer"
        employee4.profileURL = "https://scontent-arn2-1.xx.fbcdn.net/v/t1.0-9/1474526_783028925044434_1110251092_n.jpg?oh=ecdf234d4e8a77c7cb82e2ad7abcbd3b&oe=57E77F8A"
        
        let employee5 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee5.name = "Thanh Binh Tran"
        employee5.company = company5
        employee5.position = "Manager"
        employee5.profileURL = "https://scontent-arn2-1.xx.fbcdn.net/v/t1.0-9/989_919947081388479_5874319862330865673_n.jpg?oh=0bd5535381f1f585cbc094d0b3b757e5&oe=57A0EECB"
        
        let employee6 = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee6.name = "Khanh Nguyen"
        employee6.company = company6
        employee6.position = "Tester"
        employee6.profileURL = "https://scontent-arn2-1.xx.fbcdn.net/v/t1.0-9/10410328_1613020138909502_3964188692878317186_n.jpg?oh=819db4213edac79fa7970774564c41d4&oe=57B9DEB3"
        
        
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

