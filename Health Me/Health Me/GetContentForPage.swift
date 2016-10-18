
//
//  GetContentForPage.swift
//  Health Me
//
//  Created by Linh Hoang on 5/12/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation

class GetContentForPage {
    var remedies = [String]()
    var subtitles = [String]()
    
    func getText(symptom: String) -> [String]{
        //very specific path needs to be changed
        //let path = "/Users/Linh/Documents/IOS/Health Me/Health Me/" + symptom + ".txt"
        let path = NSBundle.mainBundle().pathForResource(symptom, ofType: "txt")
        do{
            let text = try NSString(contentsOfFile: path!, encoding: NSASCIIStringEncoding) as String
            remedies = text.componentsSeparatedByString("\n")
            return remedies
        } catch{
            print("Oh no")
            return remedies
        }
    }
    
    func getNumRemedies() -> Int{
        let numRemedies: Int = remedies.count - 1
        return numRemedies
    }
}
