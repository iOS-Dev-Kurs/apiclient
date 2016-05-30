
//  Created by Nils Fischer on 22.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Moya



class SWViewController: UITableViewController, UITextFieldDelegate {
    
    /// The SWAPI provider that handles requests for server resources
    var swAPI: MoyaProvider<SWAPI>!
    
    
    @IBOutlet var Laden: UIButton!
    @IBOutlet var Textfeld: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        Textfeld.delegate = self
    }
    
    
    // MARK: Actions
    
    @IBAction func PerformRequest(sender: UIButton) {
        swAPI.request(swAPI) {result in
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    print(response)
                    let json = try JSON (data: reponse.data)
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        
        
        
    }
}

extension SWViewController {
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
      }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
}


