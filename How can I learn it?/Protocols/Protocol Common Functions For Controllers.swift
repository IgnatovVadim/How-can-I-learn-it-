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
    func alertForAddingAndEditingtObjectWith(titleOfAlert: (String, String), currentNameOfObject: String, createOrEditObjectWithClosure: @escaping (String) -> Void) -> (UIAlertController)
    
    func sorting(massive: inout [ThingsForDevelopment])
    
    func reorderObjects(in massiveOfObjects: inout [ThingsForDevelopment], fromRow: Int, toRow: Int, isDelete: Bool)
    
    func deleteObject(from massiveOfObjects: inout [ThingsForDevelopment], with indexPath: IndexPath)
    
    func switchOnOrOffEditingMode(in tableView: inout UITableView, with editButton: inout UIBarButtonItem)
}
