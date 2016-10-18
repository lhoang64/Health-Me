//
//  SavedViewController.swift
//  Health Me
//
//  Created by Linh Hoang on 5/16/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit

class SavedViewController: UICollectionViewController{ //UICollectionViewDataSource, UICollectionViewDelegate{
    var savedCellLabels = ["Cough","Fever","Headache"]
    @IBOutlet weak var cellLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedCellLabels.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! UICollectionViewCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath)
        return cell
        
    }
}
