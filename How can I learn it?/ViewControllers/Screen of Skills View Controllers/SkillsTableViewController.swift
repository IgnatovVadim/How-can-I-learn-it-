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
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    var skills: [ThingsForDevelopment] = []
    let entity = NSEntityDescription.entity(forEntityName: EntityName.skills.rawValue, in: Skills.context)!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        skills = Skills.fetchDataFromDatabase(entity: EntityName.skills.rawValue)
        
        sorting(massive: &skills)
    }
    
    @IBAction func editMode(_ sender: UIBarButtonItem)
    {
        var editButton = sender
        switchOnOrOffEditingMode(in: &tableView, with: &editButton)
    }
    
    func editSkill(currentNameOfSkill: String, indexPath: IndexPath?)
    {
        let funcForEditSkillwith = { (newNameOfObject: String) -> Void in
            
            self.skills[indexPath!.row].name = newNameOfObject
            
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            
            self.saveData()
            
        }
        
        let alertForEditSkill = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.edit.rawValue, NameOfObjectInAlert.skills.rawValue), currentNameOfObject: currentNameOfSkill, createOrEditObjectWithClosure: funcForEditSkillwith)
        
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
        
        let alertForCreateSkill = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.create.rawValue, NameOfObjectInAlert.skills.rawValue), createOrEditObjectWithClosure: funcForCreateNewSkillWith)
        
        present(alertForCreateSkill, animated: true)
        
    }
    
    @IBAction func addNewSkill(_ sender: UIBarButtonItem) {
        createNewSkill()
    }
    
    @objc func editingSkill(longPressGesture: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPressGesture.view as! SkillsTableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let skill = skills[indexPath.row]
            
            editSkill(currentNameOfSkill: skill.name!, indexPath: indexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let image = UIImage(named: "firstScreen.jpg")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 1)
        {
            return skills.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: SkillsTableViewCell
        
        if (indexPath.section == 0)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellForNameOfTable", for: indexPath) as! SkillsTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SkillsTableViewCell
            
            let skill = skills[indexPath.row]
            
            let longPressGestureForEditingNameOfSkill = UILongPressGestureRecognizer(target: self, action: #selector(editingSkill(longPressGesture:)))
            longPressGestureForEditingNameOfSkill.minimumPressDuration = 0.7
            cell.addGestureRecognizer(longPressGestureForEditingNameOfSkill)
            cell.nameOfSkill.text! = "\(skill.name!)"
            cell.detailButton.tag = indexPath.row
            cell.viewForCell.layer.borderColor = UIColor.black.cgColor
            cell.viewForCell.layer.borderWidth = 1
            cell.viewForCell.layer.cornerRadius = 5
            cell.detailButton.layer.shadowColor = UIColor.black.cgColor
            cell.detailButton.layer.shadowRadius = 5
            cell.detailButton.layer.shadowOpacity = 5
            
        }
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToDetailOfSkill"
        {
            let destination = segue.destination as! DetailOfSkillViewController
            let button = sender as? UIButton
            let skill = skills[(button?.tag)!] as! Skills
            
            destination.skill = skill
        }
        
        if let navigationController = segue.destination as? UINavigationController
        {
            if let destination = navigationController.topViewController as? WaysOfLearningTableViewController
            {
                let skill = skills[tableView.indexPathForSelectedRow!.row] as? Skills
                destination.skill = skill
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 1)
        {
            return true
        }
        
        return false
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 1)
        {
            return true
        }
        
        return false
    }
    
}
