//
//  calculateEmojis.swift
//  EmojiMe
//
//  Created by Max Simon on 24.05.16.
//  Copyright © 2016 Max Simon. All rights reserved.
//

import UIKit
import Freddy


// Verfügbare Emotionen
enum Emotion {
    case Angry, Contemptuous, Disgusted, Afraid, Happy, Neutral, Sad, Surprised
    var description: String {
        switch self {
        case .Angry:
            return "😠"
        case .Contemptuous:
            return "😤"
        case .Disgusted:
            return "😣"
        case .Afraid:
            return "😥"
        case .Happy:
            return "😊"
        case .Neutral:
            return "😑"
        case .Sad:
            return "😞"
        case .Surprised:
            return "😳"
        default:
            return ""
        }
    }
    // Abstände in Prozent
    var eyes: (left: CGFloat, right: CGFloat, top: CGFloat) {
        switch self {
        case .Angry:
            return (CGFloat(0.36), CGFloat(0.64), CGFloat(0.58))
        case .Contemptuous:
            return (CGFloat(0.33), CGFloat(0.66), CGFloat(0.36))
        case .Disgusted:
            return (CGFloat(0.4), CGFloat(0.6), CGFloat(0.55))
        case .Afraid:
            return (CGFloat(0.36), CGFloat(0.64), CGFloat(0.55))
        case .Happy:
            return (CGFloat(0.36), CGFloat(0.64), CGFloat(0.36))
        case .Neutral:
            return (CGFloat(0.36), CGFloat(0.64), CGFloat(0.38))
        case .Sad:
            return (CGFloat(0.33), CGFloat(0.66), CGFloat(0.58))
        case .Surprised:
            return (CGFloat(0.27), CGFloat(0.73), CGFloat(0.49))
        default:
            return (0.33, 0.66, 0.4)
        }
    }
}

// struct Person
struct Person {
    var faceRectangle: Rectangle
    
    var leftEye: CGPoint = CGPointZero
    var rightEye: CGPoint = CGPointZero
    

    var scores: [Emotion: Double] = [:]
    let compositedEmotion: Emotion
    
}


// Init für Freddy-Aufruf --> JSON-Daten auf Person anpassen
extension Person: JSONDecodable {
    public init(json: JSON) throws {
        let top = try json.int("faceRectangle", "top")
        let left = try json.int("faceRectangle", "left")
        let width = try json.int("faceRectangle", "width")
        let height = try json.int("faceRectangle", "width")
        
        let faceRectangle = Rectangle(left: left, top: top, width: width, height: height)
        self.faceRectangle = faceRectangle
        
        
        // Emotionen, auf die ich prüfen will
        let disgust = try json.double("scores", "disgust")
        self.scores[.Disgusted] = disgust
        let happiness = try json.double("scores", "happiness")
        self.scores[.Happy] = happiness
        let sadness = try json.double("scores", "sadness")
        self.scores[.Sad] = sadness
        let surprise = try json.double("scores", "surprise")
        self.scores[.Surprised] = surprise
        let contempt = try json.double("scores", "contempt")
        self.scores[.Contemptuous] = contempt
        let anger = try json.double("scores", "anger")
        self.scores[.Angry] = anger
        let neutral = try json.double("scores", "neutral")
        self.scores[.Neutral] = neutral
        let fear = try json.double("scores", "fear")
        self.scores[.Afraid] = fear
        
        
        // Setze daraus Emotion zusammen
        // -> nur Implementierung der Abgefragten, aber einfach auf zusammengesetzte oder entgegengesetzte übertragbar
        (self.compositedEmotion, _) = self.scores.maxElement {
            $0.1 < $1.1
        }!
        
    }
    
}

struct Rectangle: Equatable {
    let left: Int
    let top: Int
    let width: Int
    let height: Int
    // Für Winkelbestimmung
    var leftEye: CGPoint = CGPointZero
    var rightEye: CGPoint = CGPointZero
    
    var description: String {
        return "\(left),\(top),\(width),\(height)"
    }
    
    init(left: Int, top: Int, width: Int, height: Int) {
        self.left = left
        self.top = top
        self.width = width
        self.height = height
    }
}
func ==(lhs: Rectangle, rhs: Rectangle) -> Bool {
    if lhs.left == rhs.left && lhs.top == rhs.top && lhs.width == rhs.width && lhs.height == rhs.height {
        return true
    } else {
        return false
    }
}
extension Rectangle: JSONDecodable {
    public init(json: JSON) throws {
        let left = try json.int("faceRectangle", "left")
        self.left = left
        let top = try json.int("faceRectangle", "top")
        self.top = top
        let width = try json.int("faceRectangle", "width")
        self.width = width
        let height = try json.int("faceRectangle", "height")
        self.height = height
        
        let leftEyeX = try json.double("faceLandmarks", "pupilLeft", "x")
        let leftEyeY = try json.double("faceLandmarks", "pupilLeft", "y")
        let rightEyeX = try json.double("faceLandmarks", "pupilRight", "x")
        let rightEyeY = try json.double("faceLandmarks", "pupilRight", "y")
        

        self.leftEye = CGPoint(x: leftEyeX, y: leftEyeY)
        self.rightEye = CGPoint(x: rightEyeX, y: rightEyeY)
        
        
    }
}


