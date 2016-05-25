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
}

// struct Person
struct Person {
    let position: CGPoint
    let width: CGFloat
    let height: CGFloat
    
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
        
        self.position = CGPoint(x: left, y: top)
        self.width = CGFloat(width)
        self.height = CGFloat(height)
        
        
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




