//
//  MainViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/4/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController{
    var row1 = ["Cough", "Nausea","Fever","Headache"]
    var row2 = ["Hiccups","Bruises","Indigestion","Burns"]
    var row3 = ["Heartburn","Hangover","Stress","Insomnia"]
    var x:CGFloat = 0
    var y:CGFloat = 200
    var toPass:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
        for item in row1{
            makeButton(item,baseX: x,baseY: y)
            x = x + view.frame.width/4
        }
    }
    
    func makeButton(buttonName: String, baseX:CGFloat, baseY:CGFloat){
        let button = UIButton()
        button.frame = CGRectMake(baseX, baseY, CGFloat(view.frame.width/4), 50)
        button.setTitle(buttonName, forState: .Normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.addTarget(self, action: "returnName:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "openNewView:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func openMenu(sender: AnyObject) {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if(sender.direction == .Right){
            print("swiped right")
            performSegueWithIdentifier("openMenu", sender: nil)
        }
    }
    
    func returnName(sender: UIButton!) -> String{
        if let name = sender.titleLabel?.text{
            toPass = name
            return toPass
        }
        return toPass
    }
    
    func openNewView(sender: UIButton!){
        self.performSegueWithIdentifier("openNewView", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? SideMenuVC{
            destination.transitioningDelegate = self
        }
        
        if(segue.identifier == "openNewView"){
            let destination = segue.destinationViewController as! RemedyViewController
            destination.pageTitle = toPass
        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OpenMenuAnimation()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CloseMenuAnimation()
    }
}
