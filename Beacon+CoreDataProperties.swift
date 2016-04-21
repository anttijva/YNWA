//
//  Beacon+CoreDataProperties.swift
//  YNWAModel
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beacon {

    @NSManaged var major: String?
    @NSManaged var minor: String?
    @NSManaged var uuid: String?
    @NSManaged var accuracy: String?
    @NSManaged var company: Company?
    @NSManaged var employee: Employee?

}
