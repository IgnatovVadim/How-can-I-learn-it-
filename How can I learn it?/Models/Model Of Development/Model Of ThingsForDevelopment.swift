//
//  Model Of Development.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/12/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ThingsForDevelopment : NSManagedObject
{
    @NSManaged var name: String?
    @NSManaged var number: Int64
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    convenience init(name: String, number: Int64, entity: NSEntityDescription, insertInto context: NSManagedObjectContext)
    {
        self.init(entity: entity, insertInto: context)
        
        self.name = name
        self.number = number
    }
    
    static func fetchDataFromDatabase(entity: String) -> [ThingsForDevelopment]
    {
        let fetch = NSFetchRequest<ThingsForDevelopment>(entityName: entity)
        
        do
        {
            return try context.fetch(fetch)
        }
        catch
        {
            return []
        }
    }
    
    static func saveDataToDataBase()
    {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
 
    static func deleteFromContext(that thing: ThingsForDevelopment)
    {
        self.context.delete(thing)
    }
    
}
