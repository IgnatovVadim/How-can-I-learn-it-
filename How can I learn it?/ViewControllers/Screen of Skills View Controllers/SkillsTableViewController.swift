//
//  SkillsTableViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/11/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class SkillsTableViewController: UITableViewController {
    
    var skills = [Skills]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        skills = Skills.fetchDataFromDataBase()
        
        sort(skills: &skills)
        
    }
    
    @IBAction func editSkillsButton(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        
        tableView.setEditing(!isEditing, animated: true)
        
    }
    
    /*override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }*/
    
    func sort(skills: inout [Skills])
    {
        for i in 0..<skills.count
        {
            for j in i+1..<skills.count
            {
                if (skills[i].skillNumber > skills[j].skillNumber)
                {
                    skills.swapAt(i, j)
                }
            }
        }
    }
    
    func enterNameOfSkill(skillName: String = "", indexPath: IndexPath?)
    {
        var nameOfSkill: String = ""
        
        let enterNameOfSkill = UIAlertController(title: "Creating a Skill", message: nil, preferredStyle: .alert)
        
        enterNameOfSkill.addTextField { (enterNameOfSkill) in
            enterNameOfSkill.placeholder = "Enter Name Of The Skill"
            enterNameOfSkill.text = skillName
            
            let heightConstraint = NSLayoutConstraint(item: enterNameOfSkill, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            
            enterNameOfSkill.addConstraint(heightConstraint)
            
        }
        
        let buttonOkForEnterNameOfSkill = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let textField = enterNameOfSkill.textFields?.first, textField.text != "" else {return}
            
            nameOfSkill = textField.text!
            
            if (skillName == "")
            {
                let skill = Skills(context: Skills.context)
                self.skills.append(skill)
                self.skills[self.skills.count - 1].nameOfSkill = nameOfSkill
                self.skills[self.skills.count - 1].skillNumber = Int64(self.skills.count)
                self.tableView.reloadData()
            }
            else
            {
                self.skills[(indexPath?.row)!].nameOfSkill = nameOfSkill
                self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            }
            
            self.saveData()
            
        }
        
        let buttonCancelForEnterNameOfSkill = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        
        enterNameOfSkill.addAction(buttonOkForEnterNameOfSkill)
        enterNameOfSkill.addAction(buttonCancelForEnterNameOfSkill)
        
        present(enterNameOfSkill, animated: true)
        
    }
    
    @IBAction func addNewSkill(_ sender: UIBarButtonItem) {
        enterNameOfSkill(indexPath: nil)
    }
    
    @objc func editingNameOfSkill(longPress: UILongPressGestureRecognizer)
    {
        if (!tableView.isEditing)
        {
            let cell = longPress.view as! SkillsTableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            
            let skill = skills[indexPath.row]
            
            enterNameOfSkill(skillName: skill.nameOfSkill, indexPath: indexPath)
        }
        
    }
    
    func saveData()
    {
        Skills.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return skills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SkillsTableViewCell
        
        let skill = skills[indexPath.row]
        
        
        let longPressGestureForEditingNameOfSkill = UILongPressGestureRecognizer(target: self, action: #selector(editingNameOfSkill(longPress: )))
        cell.addGestureRecognizer(longPressGestureForEditingNameOfSkill)
        
        cell.nameOfSkill.text! = ("\(skill.nameOfSkill)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let skill = skills.remove(at: indexPath.row)
            
            Skills.deleteFromContext(this: skill)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            
            editSkillsNumber(for: &skills, fromRow: indexPath.row, toRow: skills.count)
            
            //saveData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func editSkillsNumber(for skills: inout [Skills], fromRow: Int, toRow: Int)
    {
        let numberOfEditingSkills = abs(fromRow - toRow)
        if (numberOfEditingSkills > 0)
        {
            let minIndex = fromRow < toRow ? fromRow : toRow + 1
            for i in minIndex..<(minIndex + numberOfEditingSkills)
            {
                skills[i].skillNumber = Int64(i + 1)
            }
        }
        
        saveData()
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to:IndexPath)
    {
        let skill = skills.remove(at: fromIndexPath.row)
        skill.skillNumber = Int64(to.row + 1)
        skills.insert(skill, at: to.row)
        editSkillsNumber(for: &skills, fromRow: fromIndexPath.row, toRow: to.row)
        tableView.reloadData()
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
