//
//  ActionForPlans+CoreDataClass.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(ActionForPlans)
public class ActionForPlans: NSManagedObject {

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveDataToDataBase()
    {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    static func fetchDataFromDatabase() -> [ActionForPlans]
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
    
    static func deleteFromContext(that actionForPlan: ActionForPlans)
    {
        context.delete(actionForPlan)
    }
    
}
