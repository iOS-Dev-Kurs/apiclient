//
//  TranslationResult.swift
//  APIClient
//
//  Created by Frederik on 22/06/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Freddy

struct TranslationResponse
{
    var results : [TranslationResult] = []
    
    init(json: JSON) throws {
        let array = try json.array("tuc");
        for translation in array {
            do {
                let phrase = try translation.dictionary("phrase")["text"]?.description;
                let meanings = try translation.array("meanings");
                
                var result = TranslationResult(phrase: phrase!, meanings: []);
                for meaning in meanings {
                    let entry = try meaning.string("text");
                    result.meanings.append(entry);
                }
                self.results.append(result);
            }
            catch { }
        }
    }
}

struct TranslationResult
{
    var phrase : String
    var meanings : [String]
}