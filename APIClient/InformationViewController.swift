//
//  InformationViewController.swift
//  APIClient
//
//  Created by logosal mac on 06.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//


import Foundation
import UIKit
import Freddy
import Moya
import AlamofireImage


class InformationViewController: UITableViewController {
    
    var peoples : SWPeoples?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personInformation", forIndexPath: indexPath) as! UITableViewCell
        
        
        return cell
        }


}