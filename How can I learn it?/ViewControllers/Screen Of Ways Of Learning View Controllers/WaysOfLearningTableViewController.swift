//
//  WaysOfLearningTableViewController.swift
//  How can I learn it?
//
//  Created by Вадим Игнатов on 9/27/18.
//  Copyright © 2018 Вадим Игнатов. All rights reserved.
//

import UIKit
import CoreData

class WaysOfLearningTableViewController: UITableViewController {
    
    var ways = [WaysOfLearn]()
    
    @objc func backToScreenOfSkills()
    {
        dismiss(animated: true)
        {
            
        }
    }

    @IBAction func edit(_ sender: UIBarButtonItem)
    {
        let isEditing = tableView.isEditing
        
        tableView.setEditing(!isEditing, animated: true)
    }
    
    func addNewWay(nameOfWay: String = "", indexPath: IndexPath?)
    {
        
    }
    
    @IBAction func addNewWay(_ sender: UIBarButtonItem)
    {
        let way = WaysOfLearn(context: WaysOfLearn.context)
        
        ways.append(way)
        
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WaysOfLearningTableViewCell
        
        if (indexPath.section == 0)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "StaticCell", for: indexPath) as! WaysOfLearningTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "DynamicCell", for: indexPath) as! WaysOfLearningTableViewCell
            cell.label1.text = "a"
            cell.label2.text = "b"
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
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
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
