//
//  TasksTableViewCell.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfTask: UILabel!
    @IBOutlet weak var additionalInformation: UILabel!
    
    @IBOutlet weak var viewForCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
