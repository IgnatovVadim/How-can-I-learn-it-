//
//  WaysOfLearn+CoreDataClass.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(WaysOfLearn)
public class WaysOfLearn: NSManagedObject {

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveDataToDataBase()
    {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    static func fetchDataFromDatabase() -> [WaysOfLearn]
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
    
    static func deleteFromContext(that wayOfLearn: WaysOfLearn)
    {
        context.delete(wayOfLearn)
    }
    
}
