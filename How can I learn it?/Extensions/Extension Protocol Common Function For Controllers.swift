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
    func alertForAddingAndEditingtObjectWith(titleOfAlert: (String, String), currentNameOfObject: String = "", createOrEditObjectWithClosure: ((String) -> Void)?) -> (UIAlertController)
    {
        
        var uiAlertToCreateOrEditObject = UIAlertController(title: "\(titleOfAlert.0) \(titleOfAlert.1)" , message: nil, preferredStyle: .alert)
        
        uiAlertToCreateOrEditObject.addTextField { (textField) in
            textField.placeholder = "Enter New \(titleOfAlert.1) Name"
            textField.text = currentNameOfObject
            
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            textField.addConstraint(heightConstraint)
        }
        
        
        if (titleOfAlert.1 != "Task")
        {
           let buttonOK = buttonOKIn(alert: uiAlertToCreateOrEditObject, with: createOrEditObjectWithClosure)
            
            uiAlertToCreateOrEditObject.addAction(buttonOK)
        }
        
        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        uiAlertToCreateOrEditObject.addAction(buttonCancel)
        
        return (uiAlertToCreateOrEditObject)
    }
    
    func buttonOKIn(alert: UIAlertController, with createOrEditObjectWithClosure: ((String) -> Void)?) -> UIAlertAction
    {
        let buttonOK = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let textField = alert.textFields?.first, textField.text != "" else {return}
            
            let newNameOfObject = textField.text!
            
            createOrEditObjectWithClosure!(newNameOfObject)
            
        }
        
        return buttonOK
    }
    
}

extension commonFunctionsForControllers
{
    func mergeSort(massive: inout [ThingsForDevelopment], start: Int, finish: Int)
    {
        if (start < finish)
        {
            var center = (start + finish) / 2
            mergeSort(massive: &massive, start: start, finish: center)
            mergeSort(massive: &massive, start: center + 1, finish: finish)
            merge(massive: &massive, start: start, center: center, finish: finish)
        }
    }
    
    func merge(massive: inout [ThingsForDevelopment], start: Int, center: Int, finish: Int)
    {
        let leftSide = massive[start...center]
        let rightSide = massive[(center + 1)...finish]
        
        var i = start
        var j = center + 1
        
        for index in start...finish
        {
            if i > center
            {
                massive[index] = rightSide[j]
                j += 1
            }
            else if j > finish
            {
                massive[index] = leftSide[i]
                i += 1
            }
            else if massive[i].number <= massive[j].number
            {
                massive[index] = leftSide[i]
                i += 1
            }
            else
            {
                massive[index] = rightSide[j]
                j += 1
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
