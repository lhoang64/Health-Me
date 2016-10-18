//
//  CollectionViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/17/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "collectionCell"
    private let sectionInsets = UIEdgeInsets(top: 150, left: 10, bottom: 50, right: 10)
    
    let symptoms = ["Cough", "Nausea","Fever","Headache", "Hiccups","Bruises","Indigestion","Burns", "Heartburn","Hangover","Stress","Insomnia"]
    var toPass:String = ""
    
    var searchedSymptom: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
        
        let mainLabel = UILabel(frame: CGRectMake(0,120,view.frame.width,50))
        mainLabel.text = "What do you need help with?"
        mainLabel.font = UIFont(name: "Avenir-Heavy", size: 24)
        mainLabel.textAlignment = .Center
        mainLabel.textColor = UIColor(red: 209/255, green: 123/255, blue: 15/255, alpha: 1)

        self.view.addSubview(mainLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if(sender.direction == .Right){
            performSegueWithIdentifier("openMenu", sender: nil)
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symptoms.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionCell
        cell.cellName.setTitle(symptoms[indexPath.item], forState: .Normal)
        if(indexPath.item % 2 != 0){
            cell.backgroundColor = UIColor(red: 183/255, green: 240/255, blue: 173/255, alpha: 1)
        } else{
            cell.backgroundColor = UIColor(red: 138/255, green: 234/255, blue: 146/255, alpha: 1)
        }
        return cell
    }
    
    @IBAction func buttonTapped(sender: UIButton!){
        if let label = sender.titleLabel?.text{
            toPass = label
        }
        performSegueWithIdentifier("openNewView", sender: sender)
    }
    
    @IBAction func searchButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Don't see your symptom?", message: "Search for it!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({(textField) -> Void in})
        
        let searchAction = UIAlertAction(title: "Search", style: .Default, handler: {(action) -> Void in
            let textField = alert.textFields![0] as UITextField
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
            if(textField.text == ""){
                let errorAlert = UIAlertController(title: "Please enter a symptom", message: nil, preferredStyle: .Alert)
                let action = UIAlertAction(title: "Okay", style: .Cancel, handler: {(action) -> Void in
                    errorAlert.dismissViewControllerAnimated(true, completion: nil)
                })
                errorAlert.addAction(action)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                
            } else{
                self.searchedSymptom = textField.text!
                self.performSegueWithIdentifier("searchView", sender: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        })
        
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func menuButton(sender: AnyObject) {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "openNewView"){
            let destination = segue.destinationViewController as! RemedyViewController
            destination.pageTitle = toPass
        }
        
        if let destination = segue.destinationViewController as? SideMenuVC{
            destination.transitioningDelegate = self
        }
        
        if(segue.identifier == "searchView"){
            let destionation = segue.destinationViewController as! WebViewController
            destionation.oldString = searchedSymptom
        }
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OpenMenuAnimation()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CloseMenuAnimation()
    }
}
