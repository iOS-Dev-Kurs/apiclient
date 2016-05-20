//
//  Pokemon.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy
import UIKit


/// A Pokemon species such as "Bulbasaur"
struct PokemonSpecies: JSONDecodable {
    
    /// The name of the resource, such as "bulbasaur"
    let name: String
    /// The localized name of the Pokemon species, such as "Bisasam"
    let localizedName: String
    /// A short descriptive text about the Pokemon species
    let flavorText: String?
    /// The varieties this Pokemon species can occur in
    let varieties: [NamedResource<Pokemon>]
    /// The Pokedex Entries associated to this Pokemon
    let pokedexEntries: [PokedexEntry]
    
    struct PokedexEntry: JSONDecodable {
        
        let number: Int
        let pokedex: NamedResource<Pokedex>
        
        init(json: JSON) throws {
            self.number = try json.getInt(at: "entry_number")
            self.pokedex = try json.decode(at: "pokedex")
        }
        
    }
    
    init(json: JSON) throws {
        self.name = try json.getString(at: "name")
        self.localizedName = try json.getLocalized(at: "names").getString(at: "name")
        let text = try json.getLocalized(at: "flavor_text_entries").getString(at: "flavor_text")
        self.flavorText = text.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\u{c}", with: " ")
        self.varieties = try json.getArray(at: "varieties").map({ try $0.decode(at: "pokemon") })
        self.pokedexEntries = try json.decodedArray(at: "pokedex_numbers")
    }
    
}

/// A specific Pokemon variety of a species
struct Pokemon: JSONDecodable {
    
    /// The visual depictions of this Pokemon
    let sprites: PokemonSprites
    
    init(json: JSON) throws {
        self.sprites = try json.decode(at: "sprites")
    }
    
}


/// The visual depictions of a Pokemon
struct PokemonSprites: JSONDecodable {
    
    let frontDefault: ImageResource
    
    init(json: JSON) throws {
        self.frontDefault = try json.decode(at: "front_default")
    }
    
}
