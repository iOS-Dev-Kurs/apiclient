//
//  apihandler.swift
//  EmojiMe
//
//  Created by Max Simon on 23.05.16.
//  Copyright © 2016 Max Simon. All rights reserved.
//

import Moya
import Freddy
import Alamofire


enum MicrosoftFaces: TargetType {
    
    case faceDetection(UIImage) // für spätere genauere Anpassung der Smileys andie Gesichter
    case faceEmotion(UIImage, [Rectangle]?)
    
    var baseURL: NSURL {
        return NSURL(string: "https://api.projectoxford.ai")!
    }
    var path:String {
        switch self {
        case .faceDetection:
            return "/face/v1.0/detect"
        case .faceEmotion:
            return "/emotion/v1.0/recognize"
        default:
            ""
        }
    }
    
    var authKey: String {
        switch self {
        case .faceDetection:
            return "9e917e2aa3f14a00a4efd3241e799e79"
        case .faceEmotion:
            return "ce1e2a4c646b436d99de5c07edc5e98e"
        default:
            return ""
        }
    }
    
        
    var parameters: [String : AnyObject]? {
        switch self {
        case .faceDetection(let image):
            guard let imageData = getJPEGSmallerThan(image, maxSizeInMB: 0.3) else {
                return nil
            }
            return ["body": imageData, "returnFaceLandmarks": "true"]
        case .faceEmotion(let image, let rectangles):
            guard let imageData = getJPEGSmallerThan(image, maxSizeInMB: 0.3) else {
                return nil
            }
            guard let faceRectangles = rectangles else { return ["body": imageData]}
            
            return ["body": imageData, "faceRectangles": faceRectangles.map({$0.description}).joinWithSeparator(";")]
            
            
        default:
            return nil
            
        }
    }
    var method: Moya.Method {
        return .POST
    }
    
    var sampleData: NSData {
        return NSData()
    }
    
}


// Kompression anpassen, da Upload-Größe begrenzt
func getJPEGSmallerThan(image: UIImage, maxSizeInMB: Float) -> NSData? {
    let maxFilesize = maxSizeInMB * 1000 * 1024
    var startCompression: CGFloat = 1
    
    var imageData = UIImageJPEGRepresentation(image, startCompression)
    
    while imageData?.length > Int(maxFilesize) && startCompression >= 0 {
        startCompression -= 0.1
        if startCompression == 0 {
            imageData = nil
        }
        imageData = UIImageJPEGRepresentation(image, startCompression)
    }
    return imageData
    
}


// eigener Endpoint, da Authentifikation und Bild
let endPointWithAuthentification = {(target: MicrosoftFaces) -> Endpoint<MicrosoftFaces> in
    
    let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
    let parameterEncodingPic = Moya.ParameterEncoding.Custom({ requestConvertible, parameters in
        let urlRequest = requestConvertible.URLRequest.mutableCopy() as! NSMutableURLRequest
        
        guard var parameters = parameters else {return (urlRequest, nil)}
        
        if let body = parameters["body"] as? NSData {
            urlRequest.HTTPBody = body
            parameters.removeValueForKey("body")
        }
        
        let urlEncodedParameters = parameters.flatMap { key, value in
            return key + "=" + (value as! String)
        }.joinWithSeparator("&")
        
        urlRequest.URL = NSURL(string: urlRequest.URL!.absoluteString + (urlEncodedParameters.isEmpty ? "" : "?") + urlEncodedParameters)
        
        
        return (urlRequest, nil)
    })
    
    let endpoint: Endpoint<MicrosoftFaces> = Endpoint<MicrosoftFaces>(
        URL: url,
        sampleResponseClosure: { .NetworkResponse(200, target.sampleData) },
        method: target.method,
        parameters: target.parameters,
        parameterEncoding: parameterEncodingPic
    )

    return endpoint.endpointByAddingHTTPHeaderFields([
        "Ocp-Apim-Subscription-Key": target.authKey,
        "Content-Type": "application/octet-stream",
        ])
}
