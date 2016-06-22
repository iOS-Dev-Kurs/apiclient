//
//  TranslationResultViewController.swift
//  APIClient
//
//  Created by Frederik on 22/06/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit

class TranslationResultViewController : UITableViewController
{
    var response : TranslationResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = response?.results.count  else {
            return 0
        }
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Translation", forIndexPath: indexPath) as! TranslationResultCell
        guard let result = response?.results[indexPath.row] else {
            return cell
        }
        cell.Phrase.text = String(htmlEncodedString: result.phrase)
        
        var meaningContent = ""
        for meaning in result.meanings {
            meaningContent += String(htmlEncodedString: meaning) + "\n"
        }
        if meaningContent != "" {
            cell.Meaning.hidden = false
            cell.Meaning.text = meaningContent
        }
        else {
            cell.Meaning.hidden = true
        }

        return cell
    }
}