//
//  LanguageSelectViewController.swift
//  APIClient
//
//  Created by Frederik on 22/06/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit

class LanguageSelectViewController : UITableViewController
{
    var selectedLanguage: Language?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        self.selectedLanguage = Language.allLanguages[indexPath.item]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.allLanguages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LanguageCell", forIndexPath: indexPath)
        cell.textLabel?.text = Language.allLanguages[indexPath.item].name
        return cell
    }
}