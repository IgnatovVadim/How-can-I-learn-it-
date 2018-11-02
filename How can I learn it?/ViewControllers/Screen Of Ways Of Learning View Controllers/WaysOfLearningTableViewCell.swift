//
//  WaysOfLearningTableViewCell.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/27/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit

class WaysOfLearningTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOfWay: UILabel!
    
    @IBOutlet weak var viewForLabelThePlan: UIView!
    @IBOutlet weak var viewForLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
