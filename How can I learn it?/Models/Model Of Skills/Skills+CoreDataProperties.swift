//
//  Skills+CoreDataProperties.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/13/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData


extension Skills {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Skills> {
        return NSFetchRequest<Skills>(entityName: "Skills")
    }

    @NSManaged public var nameOfSkill: String
    @NSManaged public var skillNumber: Int64
    @NSManaged public var actionForPlan: NSSet?
    @NSManaged public var waysOfLearn: NSSet?

}

// MARK: Generated accessors for actionForPlan
extension Skills {

    @objc(addActionForPlanObject:)
    @NSManaged public func addToActionForPlan(_ value: ActionForPlans)

    @objc(removeActionForPlanObject:)
    @NSManaged public func removeFromActionForPlan(_ value: ActionForPlans)

    @objc(addActionForPlan:)
    @NSManaged public func addToActionForPlan(_ values: NSSet)

    @objc(removeActionForPlan:)
    @NSManaged public func removeFromActionForPlan(_ values: NSSet)

}

// MARK: Generated accessors for waysOfLearn
extension Skills {

    @objc(addWaysOfLearnObject:)
    @NSManaged public func addToWaysOfLearn(_ value: WaysOfLearn)

    @objc(removeWaysOfLearnObject:)
    @NSManaged public func removeFromWaysOfLearn(_ value: WaysOfLearn)

    @objc(addWaysOfLearn:)
    @NSManaged public func addToWaysOfLearn(_ values: NSSet)

    @objc(removeWaysOfLearn:)
    @NSManaged public func removeFromWaysOfLearn(_ values: NSSet)

}
