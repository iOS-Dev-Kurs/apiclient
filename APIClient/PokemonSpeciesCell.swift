//
//  PokemonSpeciesCell.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import AlamofireImage


class PokemonSpeciesCell: UITableViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var flavorTextLabel: UILabel!
    @IBOutlet var spriteImageview: UIImageView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    func configureForEntry(_ entry: Pokedex.Entry, pokemonSpecies: APIResource<PokeAPI, PokemonSpecies>, sprite: APIResource<PokeAPI, Pokemon>?) {

        numberLabel.text = String(entry.number)
        
        // The resource may or may not be loaded, so configure the content accordingly
        switch pokemonSpecies {
            
        case .loaded(let pokemonSpecies):
            loadingIndicator.stopAnimating()
            nameLabel.text = pokemonSpecies.localizedName
            flavorTextLabel.text = pokemonSpecies.flavorText
            
        case .loading:
            loadingIndicator.startAnimating()
            nameLabel.text = nil
            flavorTextLabel.text = nil
            
        case .failed(_, let error):
            loadingIndicator.stopAnimating()
            nameLabel.text = String(describing: error)
            flavorTextLabel.text = nil
            
        case .notLoaded:
            loadingIndicator.stopAnimating()
            nameLabel.text = nil
            flavorTextLabel.text = nil
            
        }
        
        // Try to obtain an image for the pokemon
        if let sprite = sprite {
            switch sprite {
            case .loaded(let sprite):
                spriteImageview.image = nil
                spriteImageview.isHidden = false
                // Use `AlamofireImage` to load the image from the URL and display it in the image view
                spriteImageview.af_setImage(withURL: sprite.sprites.frontDefault.url)
            default:
                spriteImageview.isHidden = true
            }
        } else {
            spriteImageview.isHidden = true
        }
    }
    
}
