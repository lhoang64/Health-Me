//
//  WebViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/4/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController{
    var webView: WKWebView?
    var oldString: String = ""
    
    @IBOutlet var originalView: UIView! = nil
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func loadView() {
        super.loadView()
        self.webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.homeremediesforyou.com/" + convertToURL(oldString) + "/")
        let request = NSURLRequest(URL: url!)
        self.webView!.loadRequest(request)
        
        navBar.title = oldString
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func convertToURL(string:String) -> String{
        let newString = string.stringByReplacingOccurrencesOfString(" ", withString: "-",options: NSStringCompareOptions.LiteralSearch, range: nil)
        return newString
    }
    
    func handleSwipes(sender: AnyObject){
        if(sender.direction == .Right){
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
