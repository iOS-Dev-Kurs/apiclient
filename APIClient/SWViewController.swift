
//  Created by Nils Fischer on 22.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya
import AlamofireImage

class SWViewController: UIViewController {
    
    /// The SWAPI provider that handles requests for server resources
    var swAPI: MoyaProvider<SWAPI>!
    
    
    
    var swPlanet: SWPlanet? {
        didSet {
            // Configure view
            self.searchTextfield.text = swPlanet?.name
            self.diameterLabel.text = swPlanet?.diameter
            self.rotation_periodLabel.text = swPlanet?.rotation_period
            self.orbital_periodLabel.text = swPlanet?.orbital_period
            self.gravityLabel.text = swPlanet?.gravity
        }
    }

    // MARK: Interface Elements
    
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var diameterLabel: UILabel!
    @IBOutlet var rotation_periodLabel: UILabel!
    @IBOutlet var orbital_periodLabel: UILabel!
    @IBOutlet var gravityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swPlanet = nil
    }
    
    
    // MARK: Actions

    @IBAction func Search(sender: AnyObject) {
        textFieldShouldReturn(self.searchTextfield)
    }

    // MARK: Loading Resources

    func loadSWPlanet(swPlanet: NamedResource<SWPlanet>) {
        loadingIndicator.startAnimating()
        swAPI.request(.planets(swPlanet)) { result in
            self.loadingIndicator.stopAnimating()
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let swPlanet = try SWPlanet(json: json)
                    // Configure view according to model
                    self.swPlanet = swPlanet
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }

    // MARK: User Interaction

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let name = textField.text else {
            return true
        }
        let SWPLanet =  NamedResource<SWPlanet>(name: name)
        self.loadSWPlanet(SWPLanet)
        return true
    }
}

