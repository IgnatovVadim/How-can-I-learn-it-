//
//  Tasks+CoreDataProperties.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: Int64
    @NSManaged public var wayOfLearn: WaysOfLearn?

}
