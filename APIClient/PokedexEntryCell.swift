//
//  PokedexCell.swift
//  APIClient
//
//  Created by Nils Fischer on 22.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit

class PokedexEntryCell: UITableViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var entriesCountLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    func configureForEntry(_ entry: PokemonSpecies.PokedexEntry, pokedex: APIResource<PokeAPI, Pokedex>) {
        numberLabel.text = String(entry.number)
        switch pokedex {
        case .loaded(let pokedex):
            loadingIndicator.stopAnimating()
            nameLabel.text = pokedex.localizedName
            entriesCountLabel.isHidden = false
            entriesCountLabel.text = String(pokedex.entries.count)
        case .loading:
            loadingIndicator.startAnimating()
            nameLabel.text = nil
            entriesCountLabel.isHidden = true
        case .notLoaded:
            loadingIndicator.stopAnimating()
            nameLabel.text = nil
            entriesCountLabel.isHidden = true
        case .failed(let error):
            loadingIndicator.stopAnimating()
            nameLabel.text = String(describing: error)
            entriesCountLabel.isHidden = true
        }
    }
    
}
