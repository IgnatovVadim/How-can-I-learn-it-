//
//  TasksTableViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 10/30/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController, commonFunctionsForControllers {
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    var tasks: [ThingsForDevelopment] = []
    var way: WaysOfLearn?
    var entity = NSEntityDescription.entity(forEntityName: EntityName.tasks.rawValue, in: Tasks.context)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = Tasks.fetchDataFromDataBase(way: way!)
        
        sorting(massive: &tasks)
        
    }
    
    @objc func backToPreviousScreen()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editingTask(longPressGesture: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPressGesture.view as? TasksTableViewCell
        if let indexPath = tableView.indexPath(for: cell!)
        {
            let task = tasks[indexPath.row]
            
            editTask(currentNameOfTask: task.name!, indexPath: indexPath)
            
        }
        
    }
    
    func editTask(currentNameOfTask: String, indexPath: IndexPath)
    {
        let editTask = { (newNameOfObject: String) -> Void in
            
            let task = self.tasks[indexPath.row]
            
            task.name = newNameOfObject
            
            self.tableView.reloadData()
            
            self.saveData()
            
        }
        
        let alertForEditingTask = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.edit.rawValue, NameOfObjectInAlert.tasks.rawValue), currentNameOfObject: currentNameOfTask, createOrEditObjectWithClosure: editTask)
        
        present(alertForEditingTask, animated: true, completion: nil)
        
    }
    
    func createNewTask()
    {
        let createNewTask = { (newNameOfObject: String) -> Void in
            
            let task = Tasks(name: newNameOfObject, number: Int64(self.tasks.count + 1), entity: self.entity!, context: Tasks.context, way: self.way!)
            
            self.tasks.append(task)
            
            self.tableView.reloadData()
            
            self.saveData()
            
        }
        
        let alertForCreateTask = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.create.rawValue, NameOfObjectInAlert.tasks.rawValue), createOrEditObjectWithClosure: createNewTask)
        
        present(alertForCreateTask, animated: true, completion: nil)
        
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem)
    {
        createNewTask()
    }
    
    @IBAction func editMode(_ sender: UIBarButtonItem)
    {
        var editButton = sender
        switchOnOrOffEditingMode(in: &tableView, with: &editButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let swipeGestureRecognizerToPreviousScreen = UISwipeGestureRecognizer(target: self, action: #selector(backToPreviousScreen))
        swipeGestureRecognizerToPreviousScreen.direction = .right
        tableView.gestureRecognizers?.append(swipeGestureRecognizerToPreviousScreen)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 1)
        {
            return tasks.count
        }
        
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: TasksTableViewCell
        
        if (indexPath.section == 0)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellForNameOfTable", for: indexPath) as! TasksTableViewCell
            cell.nameOfTask.text = "Tasks For Learn Way \n '\((way?.name)!)'"
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TasksTableViewCell
            
            let task = tasks[indexPath.row]
            
            let longPressGestureForEeditingTask = UILongPressGestureRecognizer(target: self, action: #selector(editingTask(longPressGesture:)))
            longPressGestureForEeditingTask.minimumPressDuration = 0.7
            cell.addGestureRecognizer(longPressGestureForEeditingTask)
            cell.viewForCell.layer.cornerRadius = 10
            cell.viewForCell.layer.borderWidth = 1
            cell.viewForCell.layer.borderColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
            cell.viewForCell.layer.shadowRadius = 4
            cell.viewForCell.layer.shadowOpacity = 0.5
            cell.nameOfTask.text = task.name!
            cell.additionalInformation.text = task.name!
        }
        
        return cell
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
            
            deleteObject(from: &tasks, with: indexPath)
            
            reorderObjects(in: &tasks, fromRow: indexPath.row, toRow: tasks.count, isDelete: true)
            
            tableView.reloadData()
            
            saveData()
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        reorderObjects(in: &tasks, fromRow: fromIndexPath.row, toRow: to.row, isDelete: false)
        
        tableView.reloadData()
        
        saveData()
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        if (indexPath.section == 1)
        {
            return true
        }
        
        return false
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
