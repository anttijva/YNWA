//
//  Employee+CoreDataProperties.swift
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

extension Employee {

    @NSManaged var birthday: NSDate?
    @NSManaged var name: String?
    @NSManaged var position: String?
    @NSManaged var profileURL: String?
    @NSManaged var company: Company?
    @NSManaged var beacon: Beacon?

}
