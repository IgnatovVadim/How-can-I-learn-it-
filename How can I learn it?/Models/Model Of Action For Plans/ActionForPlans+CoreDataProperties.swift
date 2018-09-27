//
//  ActionForPlans+CoreDataProperties.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/13/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData


extension ActionForPlans {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActionForPlans> {
        return NSFetchRequest<ActionForPlans>(entityName: "ActionForPlans")
    }

    @NSManaged public var actionNumber: Int64
    @NSManaged public var nameOfAction: String?
    @NSManaged public var skill: Skills?

}
