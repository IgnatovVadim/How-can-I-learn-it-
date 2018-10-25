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
    
    var skills: [ThingsForDevelopment] = []
    let entity = NSEntityDescription.entity(forEntityName: entityName.skills.rawValue, in: Skills.context)!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        skills = Skills.fetchDataFromDatabase(entity: entityName.skills.rawValue)
        
        sorting(massive: &skills)
        
    }
    
    @IBAction func editSkillsButton(_ sender: UIBarButtonItem)
    {
        switchOnOrOffEditingObjects(in: &self.tableView)
    }
    
    func editSkill(currentNameOfSkill: String, indexPath: IndexPath?)
    {
        let funcForEditSkillwith = { (newNameOfObject: String) -> Void in
            
            self.skills[indexPath!.row].name = newNameOfObject
            
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            
            self.saveData()
            
        }
        
        let alertForEditSkill = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.edit.rawValue, String(entityName.skills.rawValue.dropLast())), currentNameOfObject: currentNameOfSkill, createOrEditObjectWithClosure: funcForEditSkillwith)
        
        present(alertForEditSkill, animated: true, completion: nil)
        
    }
    
    func createNewSkill()
    {
        // Closure to create an object of class Skill for send to extension "common functions for controllers" in a function that return UIAlert
        let funcForCreateNewSkillWith = { (newNameOfObject: String) -> Void in
            
            let skill = Skills(name: newNameOfObject, number: Int64(self.skills.count + 1), entity: self.entity, insertInto: Skills.context)
            self.skills.append(skill)
            
            self.tableView.reloadData()
            
            self.saveData()
        }
        
        let alertForCreateSkill = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.create.rawValue, String(entityName.skills.rawValue.dropLast())), createOrEditObjectWithClosure: funcForCreateNewSkillWith)
        
        present(alertForCreateSkill, animated: true)
        
    }
    
    @IBAction func addNewSkill(_ sender: UIBarButtonItem) {
        createNewSkill()
    }
    
    @objc func editSkill(longPress: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPress.view as! SkillsTableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let skill = skills[indexPath.row]
            
            editSkill(currentNameOfSkill: skill.name!, indexPath: indexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SkillsTableViewCell
        
        let skill = skills[indexPath.row]
        
        let longPressGestureForEditingNameOfSkill = UILongPressGestureRecognizer(target: self, action: #selector(editSkill(longPress: )))
        longPressGestureForEditingNameOfSkill.minimumPressDuration = 0.7
        cell.addGestureRecognizer(longPressGestureForEditingNameOfSkill)
        
        cell.nameOfSkill.text! = ("\(skill.name!) + \(skill.number)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            deleteObject(from: &skills, with: indexPath)
            
            reorderObjects(in: &skills, fromRow: indexPath.row, toRow: skills.count, isDelete: true)
            
            tableView.reloadData()
            
            saveData()
            
        } else if editingStyle == .insert {
            
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to:IndexPath)
    {        
        reorderObjects(in: &skills, fromRow: fromIndexPath.row, toRow: to.row, isDelete: false)
        
        tableView.reloadData()
        
        saveData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController
        {
            if let destination = navigationController.topViewController as? WaysOfLearningTableViewController
            {
                destination.skill = skills[tableView.indexPathForSelectedRow!.row] as? Skills
            }
        }
    }
    
    // MARK: - Navigation
    
    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
