//
//  SkillsTableViewCell.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/11/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfSkill: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
