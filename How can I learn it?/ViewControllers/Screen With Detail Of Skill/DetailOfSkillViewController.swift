//
//  DetailOfSkillViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 11/3/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class DetailOfSkillViewController: UIViewController, commonFunctionsForControllers {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labelForNameOfView: UILabel!
    var skill: Skills?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.borderColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 2
        
        labelForNameOfView.text = "Why Must You Do '\(skill!.name!)'?"
        textView.text = skill!.detail
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        skill?.detail = textView.text
        
        saveData()
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
