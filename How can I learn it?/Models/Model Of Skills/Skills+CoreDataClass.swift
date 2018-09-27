//
//  Skills+CoreDataClass.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/13/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Skills)
public class Skills: NSManagedObject {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveContext()
    {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    static func fetchDataFromDataBase() -> [Skills]
    {
        do
        {
            return try context.fetch(fetchRequest())
        }
        catch
        {
            return []
        }
    }
    
    static func deleteFromContext(this skill: Skills)
    {
        context.delete(skill)
    }
    
}
