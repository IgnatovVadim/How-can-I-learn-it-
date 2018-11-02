//
//  ActionsForPlanTableViewCell.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit

class ActionsForPlansTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameOfAction: UILabel!
    
    @IBOutlet weak var viewForCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
