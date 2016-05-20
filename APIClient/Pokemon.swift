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
            self.number = try json.int("entry_number")
            self.pokedex = try json.decode("pokedex")
        }
        
    }
    
    init(json: JSON) throws {
        self.name = try json.string("name")
        self.localizedName = try json.localized("names").string("name")
        self.flavorText = try json.localized("flavor_text_entries").string("flavor_text").stringByReplacingOccurrencesOfString("\n", withString: " ")
        self.varieties = try json.array("varieties").map({ try $0.decode("pokemon") })
        self.pokedexEntries = try json.arrayOf("pokedex_numbers")
    }
    
}

/// A specific Pokemon variety of a species
struct Pokemon: JSONDecodable {
    
    /// The visual depictions of this Pokemon
    let sprites: PokemonSprites
    
    init(json: JSON) throws {
        self.sprites = try json.decode("sprites")
    }
    
}


/// The visual depictions of a Pokemon
struct PokemonSprites: JSONDecodable {
    
    let frontDefault: ImageResource
    
    init(json: JSON) throws {
        self.frontDefault = try json.decode("front_default")
    }
    
}
