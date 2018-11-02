//
//  Extension UIViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/10/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController
{
    enum CreateOrEditObjectInAlert : String
    {
        case create = "Creating A New"
        case edit = "Editing Name Of The"
    }
}

extension UIViewController
{
    enum EntityName : String
    {
        case skills = "Skills"
        case waysOfLearn = "WaysOfLearn"
        case actionsForPlans = "ActionsForPlans"
        case tasks = "Tasks"
    }
}

extension UIViewController
{
    enum NameOfObjectInAlert : String
    {
        case skills = "Skill"
        case waysOfLearn = "Way"
        case actionsForPlans = "Action"
        case tasks = "Task"
    }
}
