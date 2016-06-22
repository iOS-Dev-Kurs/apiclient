//
//  Utility.swift
//  APIClient
//
//  Created by Frederik on 22/06/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit

extension String {
    init(htmlEncodedString: String) {
        let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        do {
        let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self.init(attributedString.string)
        } catch {
            self.init("")
        }
    }
}
