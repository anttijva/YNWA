//
//  Company+CoreDataProperties.swift
//  ExpoEasy
//
//  Created by iosdev on 26.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Company {

    @NSManaged var companyDescription: String?
    @NSManaged var logoURL: String?
    @NSManaged var name: String?
    @NSManaged var companyURL: String?
    @NSManaged var beacon: Beacon?
    @NSManaged var employee: NSSet?

}
