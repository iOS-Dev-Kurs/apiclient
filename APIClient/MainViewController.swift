//
//  MainViewController.swift
//  APIClient
//
//  Created by Florian M. on 05/06/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya

class MainViewController: UIViewController {
    
    
    var postCodeApi: MoyaProvider<Zippopotam>? = nil
    var placeInfo: PlaceInfo? {
        didSet {
            placeNameLabel.text = self.placeInfo?.placeName
            positionLabel.text = "x: " + (self.placeInfo?.placeLatitude)! + " y: " + (self.placeInfo?.placeLongitude)!
        }
    }

    // MARK : OUTLETS
    
    @IBOutlet weak var postCodeTextfield: UITextField!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    
    @IBAction func entered(sender: AnyObject) {
        print("editing did end")
        postCodeApi?.request(.germany(postalCode: postCodeTextfield.text!)) {response in
            print(response)
            
            switch response {
                case .Success(let response):
                    do {
                        try response.filterSuccessfulStatusCodes()
                        // Try to parse the response to JSON
                        let json = try JSON(data: response.data)
                        // Try to decode the JSON to the required type
                        let placeInfo = try PlaceInfo(json: json)
                        // Configure view according to model
                        self.placeInfo = placeInfo
                        } catch {
                            print(error)
                            }
                case .Failure(let error):
                    print(error)
                }
            }
            
    }
    }
//    @IBAction func postCodeEntered(sender: AnyObject) {
//        print("editing did end")
//        postCodeApi?.request(.germany(postalCode: postCodeTextfield.text!)) {response in
//            print(response)
//            
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


