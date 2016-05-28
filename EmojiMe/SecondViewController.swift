//
//  SecondViewController.swift
//  EmojiMe
//
//  Created by Max Simon on 23.05.16.
//  Copyright © 2016 Max Simon. All rights reserved.
//

import UIKit
import Moya
import Freddy


class MainViewControlloer: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var pictureImageView: UIImageView!
    // Buttons und UIImageViewController aus Storyboard
    
    
    // Provider für API-Abfrage
    let MicrosoftProvider = MoyaProvider<MicrosoftFaces>(endpointClosure: endPointWithAuthentification)
    
    // speichert alle erkannten Personen im Bild
    // besser: detectedPersons: [Rectangle: Person]
    var detectedPersons: [Person]? {
        didSet {
            drawSmileys()
        }
    }
    
    // Hintergrund für Start
    let bestOfSmileys = ["🤗", "🙊", "👻", "💁", "😈"]
    let sizeOfStartSmileys: CGFloat = 90
    
    
    
    // Setzt Title
    func resetTitle() {
        self.title = "EmojiMe"
    }
    func setTitleToLoading() {
        let loadingTexts: [String] = ["🤔 thinking...", "🕵 let me look...", "Look @ 🦄 while waiting", "👀 just looking..."]
        let whichLoadingTextNow = Int(arc4random_uniform(UInt32(loadingTexts.count)))
        self.title = loadingTexts[whichLoadingTextNow]
    }
    func setTitleToError() {
        self.title = "Error 😩"
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.resetTitle), userInfo: nil, repeats: false)
    }
    
    // Speichert aktuelles Photo und zeigt Status an
    @IBAction func save(sender: AnyObject) {
        //UIImageWriteToSavedPhotosAlbum(pictureImageView.image!, self, nil, nil)
        
        guard let renderedPicture = self.pictureImageView.image else {return }
        // Sharing is caring
        let activityViewController = UIActivityViewController(activityItems: [ renderedPicture ], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
        self.title = "Published 💁"
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.resetTitle), userInfo: nil, repeats: false)
    }
    
    // Erlaubt, Bild auszuwählen
    @IBAction func choosePhotoButtonTapped(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
                self.presentImagePickerWithSourceType(.Camera)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            alertController.addAction(UIAlertAction(title: "Choose from library", style: .Default, handler: { action in
                self.presentImagePickerWithSourceType(.PhotoLibrary)
            }))
        }
        alertController.addAction(UIAlertAction(title: "Abbrechen", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    private func presentImagePickerWithSourceType(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    // lässt ImagePicker wieder verschwinden 🙌
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Bild löschen
    @IBAction func deleteImage(sender: AnyObject) {
        if pictureImageView.image == nil {
            return
        }
        pictureImageView.image = nil
        detectedPersons = nil
        self.title = "Okay 🖕"
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.resetTitle), userInfo: nil, repeats: false)
        changeBackground()
    }

    
    // lädt Bild in App und handelt API-Abfrage
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            clearSubviews()
            pictureImageView.contentMode = .ScaleAspectFit
            pictureImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        // startet API-Abfrage
        setTitleToLoading()
        askMicrosoftWithAPlease()
        
    }
    
    
    // versucht JSON-Abfrage in Struct Person umzuwandeln
    func mapUsThePersons(data: JSON, faces: [Rectangle]?) {
        do {
            var newPersons = try data.array().map(Person.init)
            
            // Ordne Personen Gesichter zu
            if faces != nil {
                var PersonsWithEyes: [Person] = []
                for var person in newPersons {
                    var PersonWithEyes = faces!.filter({$0 == person.faceRectangle})
                    if PersonWithEyes.count == 1 {
                        person.leftEye = PersonWithEyes[0].leftEye
                        person.rightEye = PersonWithEyes[0].rightEye
                    }
                    PersonsWithEyes.append(person)
                }
                newPersons = PersonsWithEyes
            }
            
            detectedPersons = newPersons
        }
        catch {
            self.setTitleToError()
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.resetTitle), userInfo: nil, repeats: false)
            detectedPersons = nil
        }
    }
    
    // API-Abfrage und so
    func askMicrosoftWithAPlease() {
        if let image = pictureImageView.image {
            // normale Facedetection
            MicrosoftProvider.request(.faceDetection(image), completion: { result in
                switch result {
                case .Success(let response):
                    do {
                        let json = try JSON(data: response.data)
                        let faces = try json.array().map(Rectangle.init)
                    
                        print(faces)
                        
                        // Emotion-Detection mit bereits getaner Face-Detection
                        self.MicrosoftProvider.request(.faceEmotion(image, faces), completion: { result in
                            switch result {
                            case .Success(let response):
                                do {
                                    let jsonEmotion = try JSON(data: response.data)
                                    self.mapUsThePersons(jsonEmotion, faces: faces)
                                    
                                    print(self.detectedPersons)
                                    
                                }
                                catch {
                                    print("was not able to parse emotions")
                                    self.setTitleToError()
                                }
                            case .Failure(let error):
                                self.setTitleToError()
                                print(error)
                            }
                        })
                        
                    } catch {
                        print("was not able to parse faces")
                        self.setTitleToError()
                    }
                case .Failure(let error):
                    self.setTitleToError()
                    print(error)
                }
            })
            
        }
        else {
            self.setTitleToError()
        }
        
    }
    
    
    // Malt Smileys aufs Bild
    func drawSmileys() {
        
        
        print(detectedPersons)
        
        guard let image = pictureImageView.image else {return }
        UIGraphicsBeginImageContext(image.size)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        
        let context = UIGraphicsGetCurrentContext()
        
        guard let persons = detectedPersons else { return }
        
        var width: CGFloat
        var x: CGFloat
        var y: CGFloat
        
        
        for person in persons {
            
            CGContextSaveGState(context)
            
            if person.leftEye != CGPointZero { // Falls das mit den Augen gesetzt ist, drehe Koordinatensystem
                let eyewidth = sqrt(pow(person.rightEye.x - person.leftEye.x, 2) + pow(person.rightEye.y - person.leftEye.y, 2))
                width = eyewidth/(person.compositedEmotion.eyes.right - person.compositedEmotion.eyes.left)
                
                
                
                //let x_center =
                let x_center = CGFloat(0)
                //let y_center =
                let y_center = CGFloat(0)
                
                let angle = atan2(person.rightEye.y - person.leftEye.y, person.rightEye.x - person.leftEye.x)
                //let angle = CGFloat(0)
                
                CGContextTranslateCTM(context, x_center, y_center)
                CGContextRotateCTM(context, angle)
                
                let newXOfLeftEye = person.leftEye.x*cos(angle) + person.leftEye.y*sin(angle)
                let newYOfLeftEye = -person.leftEye.x*sin(angle) + person.leftEye.y*cos(angle)
                
                x = CGFloat(newXOfLeftEye - person.compositedEmotion.eyes.left*width)
                y = CGFloat(newYOfLeftEye - person.compositedEmotion.eyes.top*width)
                
                
            }
            else { // Dann versuchen irgendwie noch zu retten :D
                x = CGFloat(person.faceRectangle.left)
                y = CGFloat(person.faceRectangle.top)
                
                width = CGFloat(person.faceRectangle.width)
            }
            
            var rect: CGRect = CGRectMake(x, y, width , width)
            let textFontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica Bold", size: width)!]
            person.compositedEmotion.description.drawInRect(rect, withAttributes: textFontAttributes)
            

            CGContextRestoreGState(context)
            
        }
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        pictureImageView.image = newImage
        self.resetTitle()
        
    }
    
    
    func clearSubviews() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
    }
    
    func changeBackground() {
        
        clearSubviews()
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let randomInt = Int(arc4random_uniform(UInt32(bestOfSmileys.count)))
        
        //UIGraphicsBeginImageContext(CGSize(width: sizeOfStartSmileys, height: sizeOfStartSmileys))
        UIGraphicsBeginImageContext(screenSize)
        let x = 0.5*screenSize.width - 0.5*sizeOfStartSmileys
        let y = 0.5*screenSize.height - 0.5*sizeOfStartSmileys
        var rect: CGRect = CGRectMake(x, y, 2*sizeOfStartSmileys, 2*sizeOfStartSmileys)
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica Bold", size: sizeOfStartSmileys)!]
        bestOfSmileys[randomInt].drawInRect(rect, withAttributes: textFontAttributes)
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        self.view.addSubview(UIImageView(image: newImage))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        changeBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

