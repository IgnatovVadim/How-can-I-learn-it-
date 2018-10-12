//
//  Extension Common Function For Controllers.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/8/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension commonFunctionsForControllers
{
    func uiAlertForAddingAndEditingtObjectWith(titleOfAlert: (String, String), currentNameOfObject: String = "", indexPath: IndexPath?, createOrEditObjectWith: @escaping (String, IndexPath?) -> Void) -> (UIAlertController)
    {
        
        let uiAlertToCreateOrEditObject = UIAlertController(title: "\(titleOfAlert.0) \(titleOfAlert.1)" , message: nil, preferredStyle: .alert)
        
        uiAlertToCreateOrEditObject.addTextField { (textField) in
            textField.placeholder = "Enter New \(titleOfAlert.1) Name"
            textField.text = currentNameOfObject
            
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            textField.addConstraint(heightConstraint)
        }
        
        let buttonOk = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let textField = uiAlertToCreateOrEditObject.textFields?.first, textField.text != "" else {return}
            
            let newNameOfObject = textField.text!
            
            createOrEditObjectWith(newNameOfObject, indexPath)
            
        }
        
        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        uiAlertToCreateOrEditObject.addAction(buttonOk)
        uiAlertToCreateOrEditObject.addAction(buttonCancel)
        
        return (uiAlertToCreateOrEditObject)
    }
    
    func sort(first: NSManagedObject)
    {
        
    }
}
