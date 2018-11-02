//
//  Model Of Ways.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/18/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(WaysOfLearn)
class WaysOfLearn : ThingsForDevelopment
{
    @NSManaged var skill: Skills?
    
    convenience init(name: String, number: Int64, entity: NSEntityDescription, context: NSManagedObjectContext, skill: Skills)
    {
        self.init(entity: entity, insertInto: context)
        
        self.name = name
        self.number = number
        self.skill = skill
    }
}
