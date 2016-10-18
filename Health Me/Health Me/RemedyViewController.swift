//
//  RemedyViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/15/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RemedyViewController: UITableViewController{
    let getContentClass: GetContentForPage = GetContentForPage()
    var pageTitle: String = ""
    var cellText = [String]()
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    let manageContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var savedRems = [SavedRem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellText = getContentClass.getText(pageTitle)
        navBar.title = pageTitle + " Remedies"
        view.backgroundColor = UIColor(red: 183/255, green: 240/255, blue: 173/255, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = NSFetchRequest(entityName: "SavedRem")
        do{
            let fetchedItems = try manageContext.executeFetchRequest(request)
            savedRems = fetchedItems as! [SavedRem]
        } catch let error as NSError{
            print("couldn't fetch \(error)")
        }
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        let view = sender.superview!
        let cell = view?.superview as! CustomCellWithButton
        let toSave = cell.title.text
        
        for item in savedRems{
            if item.itemTitle! == "For \(pageTitle), " + toSave!{
                saveAlert("Remedy already saved.")
                return
            }
        }
        saveSymptom(toSave!)
        saveAlert("Remedy Saved!")

    }

    func saveAlert(alert: String){
        let alertController = UIAlertController(title: alert, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        presentViewController(alertController, animated: true, completion: nil)
        alertController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func saveSymptom(remedyName: String) {
        let remEntity = NSEntityDescription.entityForName("SavedRem", inManagedObjectContext: manageContext)
        let newRem = NSManagedObject(entity: remEntity!, insertIntoManagedObjectContext: manageContext) as! SavedRem
        
        newRem.setValue("For \(pageTitle), " + remedyName, forKey: "itemTitle")
        do{
            try manageContext.save()
            savedRems.append(newRem)
        } catch let error as NSError{
            print("couldn't save \(error)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRows = getContentClass.getNumRemedies()
        return numRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomCellWithButton = self.tableView.dequeueReusableCellWithIdentifier("remedyCell") as! CustomCellWithButton
        cell.title.text = cellText[indexPath.row]
        cell.title.font = UIFont(name: "Avenir-Light", size: 18)
        cell.title.textColor = UIColor(red: 209/255, green: 123/255, blue: 15/255, alpha: 1)
        if(indexPath.row % 2==0){
            cell.backgroundColor = UIColor(red: 183/255, green: 240/255, blue: 173/255, alpha: 0.7)
        } else{
            cell.backgroundColor = UIColor(red: 138/255, green: 234/255, blue: 146/255, alpha: 0.7)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}