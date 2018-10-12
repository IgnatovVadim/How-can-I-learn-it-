//
//  SkillsTableViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/11/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class SkillsTableViewController: UITableViewController, commonFunctionsForControllers {
    
    var skills: [Skills] = []
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        skills = Skills.fetchDataFromDatabase().sorted(by: {(firstElement: Skills, secondElement: Skills) -> Bool in
            return firstElement.number < secondElement.number
        })
        
        sort(first: skills[0])
        
    }
    
    
    @IBAction func editSkillsButton(_ sender: UIBarButtonItem)
    {
        let isEditing = tableView.isEditing
        
        tableView.setEditing(!isEditing, animated: true)
        
    }
    
    func enterNameOfSkill(isNewNameExist: Bool, currentNameOfSkill: String = "", indexPath: IndexPath?)
    {
        let createOrEditTextOfAlert: String = !isNewNameExist ? CreateOrEditObjectInAlert.create.rawValue : CreateOrEditObjectInAlert.edit.rawValue
        
        // Closure to create or edit an object of class Skill for send to extension "common functions for controllers" in a function that return UIAlert
        let funcForAlertToCreateOrEditObjectOfSkillWith = { (newNameOfObject: String, indexPath: IndexPath?) -> Void in
            
            if (!isNewNameExist)
            {
                let skill = Skills(context: Skills.context)
                self.skills.append(skill)
                self.skills[self.skills.count - 1].name = newNameOfObject
                self.skills[self.skills.count - 1].number = Int64(self.skills.count)
                self.tableView.reloadData()
            }
            else
            {
                self.skills[(indexPath?.row)!].name = newNameOfObject
                self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            }
            self.saveData()
        }
        
        let alertForAddOrEditSkill = uiAlertForAddingAndEditingtObjectWith(titleOfAlert: (createOrEditTextOfAlert, "Skill"), currentNameOfObject: currentNameOfSkill, indexPath: indexPath, createOrEditObjectWith: funcForAlertToCreateOrEditObjectOfSkillWith)
        
        present(alertForAddOrEditSkill, animated: true)
        
    }
    
    @IBAction func addNewSkill(_ sender: UIBarButtonItem) {
        enterNameOfSkill(isNewNameExist: false, indexPath: nil)
    }
    
    @objc func editingNameOfSkill(longPress: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPress.view as! SkillsTableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let skill = skills[indexPath.row]
        
        enterNameOfSkill(isNewNameExist: true, currentNameOfSkill: skill.name!, indexPath: indexPath)
    }
    
    func saveData()
    {
        Skills.saveDataToDataBase()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SkillsTableViewCell
        
        let skill = skills[indexPath.row]
        
        let longPressGestureForEditingNameOfSkill = UILongPressGestureRecognizer(target: self, action: #selector(editingNameOfSkill(longPress: )))
        cell.addGestureRecognizer(longPressGestureForEditingNameOfSkill)
        
        cell.nameOfSkill.text! = ("\(skill.name!)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let skill = skills.remove(at: indexPath.row)
            
            Skills.deleteFromContext(that: skill)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            
            editSkillsNumber(for: &skills, fromRow: indexPath.row, toRow: skills.count)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to:IndexPath)
    {
        let skill = skills.remove(at: fromIndexPath.row)
        skill.number = Int64(to.row + 1)
        skills.insert(skill, at: to.row)
        editSkillsNumber(for: &skills, fromRow: fromIndexPath.row, toRow: to.row)
        tableView.reloadData()
    }
    
    
    func editSkillsNumber(for skills: inout [Skills], fromRow: Int, toRow: Int)
    {
        let numberOfEditingSkills = abs(fromRow - toRow)
        if (numberOfEditingSkills > 0)
        {
            let minIndex = fromRow < toRow ? fromRow : toRow + 1
            for i in minIndex..<(minIndex + numberOfEditingSkills)
            {
                skills[i].number = Int64(i + 1)
            }
        }
        
        saveData()
    }
    
    // MARK: - Navigation
    
    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
