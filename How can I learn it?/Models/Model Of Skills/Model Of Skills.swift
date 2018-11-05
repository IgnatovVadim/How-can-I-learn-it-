//
//  Model Of Skills.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/12/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(Skills)
class Skills : ThingsForDevelopment
{
    @NSManaged var detail: String?
    @NSManaged var waysOfLearn: NSSet?
}
