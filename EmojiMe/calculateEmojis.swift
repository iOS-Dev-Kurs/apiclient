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
    
    // So noch hinzugefügt
    case Swipe1, Swipe2, Swipe3, Swipe4, Swipe5, Swipe6, Swipe7, Swipe8, Swipe9, Swipe10
    
    static let allValues = [Angry, Contemptuous, Disgusted, Afraid, Happy, Neutral, Sad, Surprised, Swipe1, Swipe2, Swipe3, Swipe4, Swipe5, Swipe6, Swipe7, Swipe8, Swipe9, Swipe10]
    
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
            
            
        case .Swipe1:
            return "😷"
        case .Swipe2:
            return "😭"
        case .Swipe3:
            return "😂"
        case .Swipe4:
            return "😎"
        case .Swipe5:
            return "🙄"
        case .Swipe6:
            return "🤔"
        case .Swipe7:
            return "😽"
        case .Swipe8:
            return "😻"
        case .Swipe9:
            return "😝"
        case .Swipe10:
            return "😶"
            
        default:
            return ""
        }
    }
    // Abstände in Prozent
    var eyes: (left: CGFloat, right: CGFloat, top: CGFloat) {
        // Hier könnte man mit nem Switch verschiedene Größen für die Smileys definieren
        return (0.33, 0.67, 0.4)
    }
}

// struct Person
struct Person: Equatable, Hashable  {
    var faceRectangle: Rectangle
    
    var leftEye: CGPoint = CGPointZero
    var rightEye: CGPoint = CGPointZero
    

    var scores: [Emotion: Double] = [:]
    var compositedEmotion: Emotion
    
    var hashValue: Int {
        return faceRectangle.hashValue
    }
    
}
func ==(lhs: Person, rhs: Person) -> Bool {
    if lhs.faceRectangle == rhs.faceRectangle {
        return true
    } else {
        return false
    }
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

struct Rectangle: Equatable, Hashable {
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
    var hashValue: Int {
        get {
            return "\(left)\(top)\(width)\(height)".hashValue
        }
    }
    
    init(left: Int, top: Int, width: Int, height: Int) {
        self.left = left
        self.top = top
        self.width = width
        self.height = height
    }
    func contains(x: Int, y: Int) -> Bool {
        if x >= self.left && x <= self.left + self.width && y >= self.top && y <= self.top + self.height {
            return true
        }
        else {
            return false
        }
    }
}
func ==(lhs: Rectangle, rhs: Rectangle) -> Bool {
    let maxDiff = 10
    if abs(lhs.left - rhs.left) < maxDiff && abs(lhs.top - rhs.top) < maxDiff && abs(lhs.width - rhs.width) < maxDiff && abs(lhs.height - rhs.height) < maxDiff {
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


