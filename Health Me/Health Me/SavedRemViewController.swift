//
//  SavedRemViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/19/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SavedRemViewController: UICollectionViewController{
    let sectionInsets = UIEdgeInsets(top: 50, left: 10, bottom: 50, right: 10)
    var saved = [NSManagedObject]()
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = NSFetchRequest(entityName: "Sympt")
        do{
            let fetchedItems = try managedContext.executeFetchRequest(request)
            saved = fetchedItems as! [NSManagedObject]
        } catch let error as NSError{
            print("Could not fetch \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        performSegueWithIdentifier("backToMain", sender: nil)
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saved.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CustomCollectionCell
        let item = saved[indexPath.row]
        cell.cellName.setTitle(item.valueForKey("symptName") as? String, forState: .Normal)
        cell.backgroundColor = UIColor(red: 183/255, green: 240/255, blue: 173/255, alpha: 1)
        return cell
        
    }
}

extension SavedRemViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 120, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
