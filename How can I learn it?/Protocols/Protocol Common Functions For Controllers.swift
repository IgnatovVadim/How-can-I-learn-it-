//
//  Protocol For Controllers.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/8/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol commonFunctionsForControllers
{
    func uiAlertForAddingAndEditingtObjectWith(titleOfAlert: (String, String), currentNameOfObject: String, indexPath: IndexPath?, createOrEditObjectWith: @escaping (String, IndexPath?) -> Void) -> (UIAlertController)
    
    func sort(first: NSManagedObject)
}
