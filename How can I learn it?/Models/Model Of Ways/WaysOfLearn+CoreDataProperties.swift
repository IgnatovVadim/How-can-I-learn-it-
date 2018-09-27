//
//  WaysOfLearn+CoreDataProperties.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/13/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData


extension WaysOfLearn {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaysOfLearn> {
        return NSFetchRequest<WaysOfLearn>(entityName: "WaysOfLearn")
    }

    @NSManaged public var nameOfWay: String?
    @NSManaged public var wayNumber: Int64
    @NSManaged public var skill: Skills?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension WaysOfLearn {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Tasks)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Tasks)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
