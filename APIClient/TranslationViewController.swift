//
//  InitialViewController.swift
//  APIClient
//
//  Created by Frederik on 29/05/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

class TranslationViewController : UIViewController
{
    var glosbeAPI = MoyaProvider<GlosbeAPITarget>()
    
    var destLang : Language = Language.allLanguages[1]
    var fromLang : Language = Language.allLanguages[0]
    
    var changedLangIdentifier = ""
    var translationResult : TranslationResponse?
    
    var translationResultController : TranslationResultViewController?
    
    var DestLang : Language {
        get {
            return destLang
        }
        set (value) {
            destLang = value
            SelectDestLanguage.setTitle(value.name, forState: UIControlState.Normal)
        }
    }
    var FromLang : Language {
        get {
            return fromLang
        }
        set (value) {
            fromLang = value
            SelectFromLanguage.setTitle(value.name, forState: UIControlState.Normal)
        }
    }

    
    func handleTranslationRequestResponseData(data: NSData) throws
    {
        let json = try JSON(data: data)
        let result = try TranslationResponse(json: json)
        
        translationResult = result
        TranslationContainer.hidden = false
        translationResultController?.response = result
        translationResultController?.tableView.reloadData()
    }
    
    func invokeTranslationRequest(phrase: String, from: String, dest: String)
    {
        let target = GlosbeAPITarget(phrase: phrase, from: from, dest: dest)
        
        glosbeAPI.request(target) { result in
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    try self.handleTranslationRequestResponseData(response.data)
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //NOTE(Frederik): View Controller Zeugs

    @IBOutlet weak var SelectFromLanguage: UIButton!
    @IBOutlet weak var SelectDestLanguage: UIButton!
    @IBOutlet weak var SwitchLanguage: UIButton!
    @IBOutlet weak var TranslationContainer: UIView!
    @IBOutlet weak var TextInputField: UITextField!
    
    @IBOutlet weak var OutputLabel: UILabel!
    
    @IBAction func SwitchPressed(_: UIButton) {
        let temp = FromLang
        FromLang = DestLang
        DestLang = temp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DestLang = destLang
        FromLang = fromLang
    }
    
    @IBAction override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        switch segue.identifier! {
        case "FromLanguage":
            changedLangIdentifier = "From"
            break;
        case "DestLanguage":
            changedLangIdentifier = "Dest"
            break;
        case "Translation":
            translationResultController = segue.destinationViewController as? TranslationResultViewController
            break;
        default: break;
        }
    }
    
    @IBAction func unwindToTranslation(segue: UIStoryboardSegue){
        switch segue.identifier! {
        case "SelectedLanguage":
            guard let languageSelectViewController = segue.sourceViewController as? LanguageSelectViewController,
                selectedLanguage = languageSelectViewController.selectedLanguage else {
                    return
            }
            switch changedLangIdentifier {
            case "From":
                FromLang = selectedLanguage
                if TextInputField.text != "" {
                    self.invokeTranslationRequest(TextInputField.text!, from: fromLang.identifier, dest: destLang.identifier)
                }
                break;
            case "Dest":
                DestLang = selectedLanguage
                if TextInputField.text != "" {
                    self.invokeTranslationRequest(TextInputField.text!, from: fromLang.identifier, dest: destLang.identifier)
                }
                break;
            default:
                break;
            }
            break
        default:
            break
        }
    }

    //NOTE(Frederik): Text input field callback
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let name = textField.text!
        
        self.invokeTranslationRequest(name, from: fromLang.identifier, dest: destLang.identifier)
        return true
    }
}





