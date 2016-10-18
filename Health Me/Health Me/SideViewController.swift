//
//  SideViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/4/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit

class SideMenuVC: UITableViewController{
    let menuOptions = ["Symptoms","Saved Remedies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        leftSwipe.direction = .Left
        view.addGestureRecognizer(leftSwipe)
        
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 193/255, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleSwipes(sender: AnyObject){
        if(sender.direction == .Left){
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let customCell:CustomTableCell = self.tableView.dequeueReusableCellWithIdentifier("Options") as! CustomTableCell
        customCell.title.text = menuOptions[indexPath.row]
        customCell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 193/255, alpha: 1)
        customCell.title.font = UIFont(name: "Avenir-Heavy", size: 18)
        //customCell.img.image = UIImage(named: <#T##String#>))
        return customCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        if(row == 0){
            dismissViewControllerAnimated(true, completion: nil)
        } else{
            performSegueWithIdentifier("viewSaves", sender: nil)
        }
    }
}