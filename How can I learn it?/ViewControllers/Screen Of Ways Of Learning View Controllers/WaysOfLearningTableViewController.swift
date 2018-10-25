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
    
    var ways: [ThingsForDevelopment] = []
    var skill: Skills?
    var entity = NSEntityDescription.entity(forEntityName: entityName.ways.rawValue, in: WaysOfLearn.context)!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ways = WaysOfLearn.fetchDataFromDataBase(skill: skill!)
        
        sorting(massive: &ways)
    }
    
    @objc func backToScreenOfSkills()
    {
        dismiss(animated: true)
        {
            
        }
    }
    
    @IBAction func isEditingButton(_ sender: UIBarButtonItem)
    {
        switchOnOrOffEditingObjects(in: &tableView)
    }
    
    func editWay(currentNameOfWay: String, indexPath: IndexPath?)
    {
        let editWay = { (newNameOfObject: String) -> Void in
            
            self.ways[indexPath!.row].name = newNameOfObject
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
            self.saveData()
        }
        
        let alertForEditWay = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.edit.rawValue, entityName.ways.rawValue), currentNameOfObject: currentNameOfWay, createOrEditObjectWithClosure: editWay)
        
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
        
        let alertForCreateWay = alertForAddingAndEditingtObjectWith(titleOfAlert: (CreateOrEditObjectInAlert.create.rawValue, entityName.ways.rawValue), createOrEditObjectWithClosure: createNewWay)
        
        present(alertForCreateWay, animated: true, completion: nil)
        
    }
    
    @IBAction func addNewWay(_ sender: UIBarButtonItem)
    {
        createNewWay()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backToScreenOfSkills))
        swipeGesture.direction = .right
        tableView.gestureRecognizers?.append(swipeGesture)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            return ways.count
        }
        
        return 1
    }
    
    @objc func editingWay(longPress: UILongPressGestureRecognizer)
    {
        tableView.setEditing(false, animated: true)
        
        let cell = longPress.view as! WaysOfLearningTableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let way = ways[indexPath.row]
            editWay(currentNameOfWay: way.name!, indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WaysOfLearningTableViewCell
        
        if (indexPath.section == 0)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "StaticCell", for: indexPath) as! WaysOfLearningTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "DynamicCell", for: indexPath) as! WaysOfLearningTableViewCell
            
            let way = ways[indexPath.row]
            
            let longPressGestureForEditingWay = UILongPressGestureRecognizer(target: self, action: #selector(editingWay(longPress:)))
            longPressGestureForEditingWay.minimumPressDuration = 0.7
            cell.addGestureRecognizer(longPressGestureForEditingWay)
            
            cell.nameOfWay.text = "\(way.name!) + \(way.number) "
        }
        
        return cell
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
            
            if (indexPath.section != 0)
            {
                deleteObject(from: &ways, with: indexPath)
                
                reorderObjects(in: &ways, fromRow: indexPath.row, toRow: ways.count, isDelete: true)
                
                tableView.reloadData()
                
                saveData()
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        if (fromIndexPath.section != 0)
        {
            reorderObjects(in: &ways, fromRow: fromIndexPath.row, toRow: to.row, isDelete: false)
            saveData()
        }

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
