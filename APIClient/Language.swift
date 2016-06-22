//
//  Language.swift
//  APIClient
//
//  Created by Frederik on 22/06/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

struct Language : Equatable
{
    let name : String
    let identifier : String
    
    static let allLanguages : Array<Language> =
    [
        Language(name: "Deutsch", identifier: "deu"),
        Language(name: "Englisch", identifier: "eng"),
        Language(name: "Französisch", identifier: "fra"),
        Language(name: "Griechisch", identifier: "ell"),
        Language(name: "Japanisch", identifier: "jpn"),
        Language(name: "Spanisch", identifier: "spa"),
        Language(name: "Russisch", identifier: "rus"),
        Language(name: "Polnisch", identifier: "pol")
    ]
}

func ==(lhs: Language, rhs: Language) -> Bool {
    return lhs.identifier == rhs.identifier
}