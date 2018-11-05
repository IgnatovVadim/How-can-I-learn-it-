//
//  Model Of Task.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(Tasks)
class Tasks : ThingsForDevelopment
{
    @NSManaged var wayOfLearn: WaysOfLearn?
    @NSManaged var additionalInformation: String?
    
    convenience init(name: String, additionalInformation: String?, number: Int64, entity: NSEntityDescription, context: NSManagedObjectContext, way: WaysOfLearn)
    {
        self.init(entity: entity, insertInto: context)
        
        self.name = name
        self.number = number
        self.wayOfLearn = way
        self.additionalInformation = additionalInformation!
    }
    
    static func fetchDataFromDataBase(way: WaysOfLearn) -> [ThingsForDevelopment]
    {
        let request = NSFetchRequest<ThingsForDevelopment>(entityName: "Tasks")
        
        let predicate = NSPredicate(format: "%K = %@", "wayOfLearn", way)
        request.predicate = predicate
        
        do
        {
           return try context.fetch(request)
        }
        catch
        {
            return []
        }
}
    
}
