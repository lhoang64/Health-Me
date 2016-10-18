//
//  AllSavesViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/26/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AllSavesViewController: UITableViewController{
    var remediesList = [SavedRem]()
    
    var sortedList = [String]()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let request = NSFetchRequest(entityName: "SavedRem")
        let manageContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        do{
            let fetchedItems = try manageContext.executeFetchRequest(request)
            remediesList = fetchedItems as! [SavedRem]
        } catch let error as NSError{
            print("Couldn't fetch \(error)")
        }
        
        sortedArray()
    }
    
    func sortedArray() -> [String]{
        for item in remediesList{
            sortedList.append(item.itemTitle!)
        }
        
        sortedList.sortInPlace({(item1: String, item2: String) -> Bool in
            return item1 < item2
        })
        
        return sortedList
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 210/255, green: 255/255, blue: 150/255, alpha: 1)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        performSegueWithIdentifier("backToMain", sender: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AllSavesCell = self.tableView.dequeueReusableCellWithIdentifier("savedCell") as! AllSavesCell
        let item = sortedList[indexPath.row]
        cell.name.text = item
        cell.backgroundColor = UIColor(red: 210/255, green: 255/255, blue: 150/255, alpha: 1)
        return cell
    }
}