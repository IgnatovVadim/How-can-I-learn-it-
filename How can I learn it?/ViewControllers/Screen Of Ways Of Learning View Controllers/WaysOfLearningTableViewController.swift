//
//  WaysOfLearningTableViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/27/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class WaysOfLearningTableViewController: UITableViewController, commonFunctionsForControllers {
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    var ways: [ThingsForDevelopment] = []
    var skill: Skills?
    var entity = NSEntityDescription.entity(forEntityName: EntityName.waysOfLearn.rawValue, in: WaysOfLearn.context)!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ways = WaysOfLearn.fetchDataFromDataBase(entity: EntityName.waysOfLearn.rawValue, skill: skill!)
        
        mergeSort(massive: &ways, start: 0, finish: ways.count - 1)
    }
    
    @objc func backToScreenOfSkills()
    {
        dismiss(animated: true)
        {
            
        }
    }
    
    @IBAction func editMode(_ sender: UIBarButtonItem)
    {
        var editButton = sender
        switchOnOrOffEditingMode(in: &tableView, with: &editButton)
    }
    
    func editWay(currentNameOfWay: String, indexPath: IndexPath?)
    {
        let editWay = { (newNameOfObject: String) -> Void in
            
            self.ways[indexPath!.row].name = newNameOfObject
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            self.saveData()
        }
        
        let alertForEditWay = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.edit.rawValue, NameOfObjectInAlert.waysOfLearn.rawValue), currentNameOfObject: currentNameOfWay, createOrEditObjectWithClosure: editWay)
        
        present(alertForEditWay, animated: true, completion: nil)
        
    }
    
    func createNewWay()
    {
        
        let createNewWay = { (newNameOfObject: String) -> Void in
            
            let way = WaysOfLearn(name: newNameOfObject, number: Int64(self.ways.count + 1), entity: self.entity, context: WaysOfLearn.context, skill: self.skill!)
            
            self.ways.append(way)
            self.tableView.reloadData()
            self.saveData()
            
        }
        
        let alertForCreateWay = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.create.rawValue, NameOfObjectInAlert.waysOfLearn.rawValue), createOrEditObjectWithClosure: createNewWay)
        
        present(alertForCreateWay, animated: true, completion: nil)
        
    }
    
    @IBAction func addNewWay(_ sender: UIBarButtonItem)
    {
        createNewWay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let swipeGestureRecognizerToPreviousScreen = UISwipeGestureRecognizer(target: self, action: #selector(backToScreenOfSkills))
        swipeGestureRecognizerToPreviousScreen.direction = .right
        tableView.gestureRecognizers?.append(swipeGestureRecognizerToPreviousScreen)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 2)
        {
            return ways.count
        }
        
        return 1
    }
    
    @objc func editingWay(longPressGesture: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPressGesture.view as! WaysOfLearningTableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let way = ways[indexPath.row]
            editWay(currentNameOfWay: way.name!, indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: WaysOfLearningTableViewCell
        
        if (indexPath.section == 0)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "StaticCellForNameOfTable", for: indexPath) as! WaysOfLearningTableViewCell
            cell.nameOfWay.text = "Ways To Do The Skill \n'\((skill?.name)!)'"
        }
        else if (indexPath.section == 1)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "StaticCellForPlan", for: indexPath) as! WaysOfLearningTableViewCell
            cell.viewForLabelThePlan.layer.cornerRadius = 2
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "DynamicCell", for: indexPath) as! WaysOfLearningTableViewCell
            
            let way = ways[indexPath.row]
            
            let longPressGestureForEditingWay = UILongPressGestureRecognizer(target: self, action: #selector(editingWay(longPressGesture:)))
            longPressGestureForEditingWay.minimumPressDuration = 0.7
            cell.addGestureRecognizer(longPressGestureForEditingWay)
            cell.viewForLabel.layer.cornerRadius = 2
            cell.nameOfWay.text = "\(way.name!)"
        }
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 2)
        {
            return true
        }
        
        return false
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            deleteObject(from: &ways, with: indexPath)
            
            reorderObjects(in: &ways, fromRow: indexPath.row, toRow: ways.count, isDelete: true)
            
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
        
        reorderObjects(in: &ways, fromRow: fromIndexPath.row, toRow: to.row, isDelete: false)
        saveData()
        
        tableView.reloadData()
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 2)
        {
            return true
        }
        
        return false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController
        {
            if let destination = navigationController.topViewController as? ActionsForPlansTableViewController
            {
                destination.skill = skill
            }
            else if let destination = navigationController.topViewController as? TasksTableViewController
            {
                let indexPath = tableView.indexPathForSelectedRow
                let way = ways[(indexPath?.row)!]
                destination.way = (way as! WaysOfLearn)
            }
        }
    }
    
    
}
