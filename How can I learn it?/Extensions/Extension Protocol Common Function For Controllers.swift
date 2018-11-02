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
    func alertForAddingAndEditingtObjectWith(titleOfAlert: (String, String), currentNameOfObject: String = "", createOrEditObjectWithClosure: @escaping (String) -> Void) -> (UIAlertController)
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
            
            createOrEditObjectWithClosure(newNameOfObject)
            
        }
        
        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        uiAlertToCreateOrEditObject.addAction(buttonOk)
        uiAlertToCreateOrEditObject.addAction(buttonCancel)
        
        return (uiAlertToCreateOrEditObject)
    }
}

extension commonFunctionsForControllers
{
    func sorting(massive: inout [ThingsForDevelopment])
    {
        for i in 0..<massive.count
        {
            for j in i+1..<massive.count
            {
                if (massive[i].number > massive[j].number)
                {
                    massive.swapAt(i, j)
                }
            }
        }
    }
}

extension commonFunctionsForControllers
{
    func reorderObjects(in massiveOfObjects: inout [ThingsForDevelopment], fromRow: Int, toRow: Int, isDelete: Bool)
    {
        if (!isDelete)
        {
            let object = massiveOfObjects.remove(at: fromRow)
            object.number = Int64(toRow + 1)
            massiveOfObjects.insert(object, at: toRow)
        }
        
        let numberOfEditingSkills = abs(fromRow - toRow)
        if (numberOfEditingSkills > 0)
        {
            let minIndex = fromRow < toRow ? fromRow : toRow + 1
            for i in minIndex..<(minIndex + numberOfEditingSkills)
            {
                massiveOfObjects[i].number = Int64(i + 1)
            }
        }
    }
}

extension commonFunctionsForControllers
{
    func deleteObject(from massiveOfObjects: inout [ThingsForDevelopment], with indexPath: IndexPath)
    {
        let object = massiveOfObjects.remove(at: indexPath.row)
        
        ThingsForDevelopment.deleteFromContext(that: object)
    }
}

extension commonFunctionsForControllers
{
    func saveData()
    {
        ThingsForDevelopment.saveDataToDataBase()
    }
}

extension commonFunctionsForControllers
{
    func switchOnOrOffEditingMode(in tableView: inout UITableView, with editButton: inout UIBarButtonItem)
    {
        let isEditing = !tableView.isEditing
        
        if (isEditing)
        {
            editButton.title = "Done"
        }
        else
        {
            editButton.title = "Edit"
        }
        
        tableView.setEditing(isEditing, animated: true)
        
    }
}
