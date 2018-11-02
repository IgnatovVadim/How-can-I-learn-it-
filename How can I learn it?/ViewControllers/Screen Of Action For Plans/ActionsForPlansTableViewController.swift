//
//  ActionForPlansTableViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/25/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class ActionsForPlansTableViewController: UITableViewController , commonFunctionsForControllers{
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    var actions: [ThingsForDevelopment] = []
    var skill: Skills?
    let entity = NSEntityDescription.entity(forEntityName: EntityName.actionsForPlans.rawValue, in: ActionsForPlans.context)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        actions = ActionsForPlans.fetchDataFromDataBase(entity: EntityName.actionsForPlans.rawValue, skill: skill!)
        
        sorting(massive: &actions)
    }
    
    @IBAction func editMode(_ sender: UIBarButtonItem) {
        var editButton = sender
        switchOnOrOffEditingMode(in: &tableView, with: &editButton)
    }
    
    @objc func backToPreviousScreen()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewActionForPlan(_ sender: UIBarButtonItem) {
        createNewActionForPlan()
    }
    
    func createNewActionForPlan()
    {
        let createNewAction = { (newNameOfObject: String) -> Void in
            
            let newAction = ActionsForPlans(name: newNameOfObject, number: Int64(self.actions.count + 1), entity: self.entity!, context: ActionsForPlans.context, skill: self.skill!)
            self.actions.append(newAction)
            
            self.tableView.reloadData()
            
            self.saveData()
        }
        
        let alertForCreateAction = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.create.rawValue, NameOfObjectInAlert.actionsForPlans.rawValue), createOrEditObjectWithClosure: createNewAction)
        
        present(alertForCreateAction, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGestureRecognizerToPreviousScreen = UISwipeGestureRecognizer(target: self, action: #selector(backToPreviousScreen))
        swipeGestureRecognizerToPreviousScreen.direction = .right
        tableView.gestureRecognizers?.append(swipeGestureRecognizerToPreviousScreen)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 1)
        {
            return actions.count
        }
        
        return 1
    }
    
    @objc func editingAction(longPressGesture: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPressGesture.view as! ActionsForPlansTableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let action = actions[indexPath.row]
            editAction(currentNameOfAction: action.name!, indexPath: indexPath)
        }
    }
    
    func editAction(currentNameOfAction: String, indexPath: IndexPath?)
    {
        let editAction = { (newNameOfObject: String) -> Void in
            
            self.actions[indexPath!.row].name = newNameOfObject
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            self.saveData()
        }
        
        let alertForEditWay = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.edit.rawValue, NameOfObjectInAlert.actionsForPlans.rawValue), currentNameOfObject: currentNameOfAction, createOrEditObjectWithClosure: editAction)
        
        present(alertForEditWay, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ActionsForPlansTableViewCell
        
        if (indexPath.section == 0)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellForNameOfTable", for: indexPath) as! ActionsForPlansTableViewCell
            cell.nameOfAction.text = "Plan For Skill \n '\((skill?.name)!)'"
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActionsForPlansTableViewCell
            
            let action = actions[indexPath.row]
            
            let longPressGestureForEditingAction = UILongPressGestureRecognizer(target: self, action: #selector(editingAction(longPressGesture:)))
            longPressGestureForEditingAction.minimumPressDuration = 0.7
            cell.addGestureRecognizer(longPressGestureForEditingAction)
            cell.nameOfAction.text = "\(indexPath.row + 1)) \((action.name)!)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 1)
        {
            return true
        }
        
        return false
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 1)
        {
            return true
        }
        
        return false
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            deleteObject(from: &actions, with: indexPath)
            
            reorderObjects(in: &actions, fromRow: indexPath.row, toRow: actions.count, isDelete: true)
            
            tableView.reloadData()
            
            saveData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        reorderObjects(in: &actions, fromRow: fromIndexPath.row, toRow: to.row, isDelete: false)
        
        saveData()
        
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
