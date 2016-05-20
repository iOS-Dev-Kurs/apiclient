//
//  PokemonViewController.swift
//  APIClient
//
//  Created by Nils Fischer on 22.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya
import AlamofireImage


class PokemonViewController: UIViewController {
    
    /// The Poke API provider that handles requests for server resources
    var pokeAPI: MoyaProvider<PokeAPI>!
    
    /// The Pokemon species to show here
    var pokemonSpecies: PokemonSpecies? {
        didSet {
            // Configure view
            self.searchTextfield.text = pokemonSpecies?.name
            self.nameLabel.text = pokemonSpecies?.localizedName
            self.flavorTextLabel.text = pokemonSpecies?.flavorText
            self.showPokedexEntriesButton.hidden = pokemonSpecies == nil
            self.sprite = nil
            if let sprite = pokemonSpecies?.varieties.first {
                self.loadSprite(sprite)
            }
        }
    }
    /// The image information for the pokemon species if loaded
    private var sprite: Pokemon? {
        didSet {
            if let spriteURL = sprite?.sprites.frontDefault.url {
                self.spriteImageview.hidden = true
                // Use `AlamofireImage` to load the image from the URL and display it in the image view
                self.spriteImageview.af_setImageWithURL(spriteURL) { response in
                    if case .Success = response.result {
                        self.spriteImageview.hidden = false
                    }
                }
            } else {
                self.spriteImageview.hidden = true
            }
        }
    }
    
    
    // MARK: Interface Elements
    
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var spriteImageview: UIImageView!
    @IBOutlet var spriteLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet var flavorTextLabel: UILabel!
    @IBOutlet var showPokedexEntriesButton: UIButton!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonSpecies = nil
    }
    
    
    // MARK: Loading Resources
    
    func loadPokemonSpecies(pokemonSpecies: NamedResource<PokemonSpecies>) {
        loadingIndicator.startAnimating()
        pokeAPI.request(.pokemonSpecies(pokemonSpecies)) { result in
            self.loadingIndicator.stopAnimating()
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let pokemonSpecies = try PokemonSpecies(json: json)
                    // Configure view according to model
                    self.pokemonSpecies = pokemonSpecies
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func loadSprite(pokemon: NamedResource<Pokemon>) {
        spriteLoadingIndicator.startAnimating()
        pokeAPI.request(.pokemon(pokemon)) { result in
            self.spriteLoadingIndicator.stopAnimating()
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let pokemon = try Pokemon(json: json)
                    // Configure view according to model
                    self.sprite = pokemon
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }

    
    // MARK: User Interaction
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let name = textField.text else {
            return true
        }
        self.loadPokemonSpecies(NamedResource(name: name))
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "showPokedexEntry":
            guard let pokedexEntriesViewController = (segue.destinationViewController as? UINavigationController)?.topViewController as? PokedexEntriesViewController else {
                return
            }
            guard let pokemonSpecies = self.pokemonSpecies else {
                return
            }
            pokedexEntriesViewController.pokeAPI = pokeAPI
            pokedexEntriesViewController.pokemonSpecies = pokemonSpecies
        default:
            break
        }
    }
    
    @IBAction func unwindToPokemon(segue: UIStoryboardSegue) {
        switch segue.identifier! {
        case "showPokemonSpecies":
            guard let pokemonSpeciesProvider = segue.sourceViewController as? PokemonSpeciesProvider else {
                return
            }
            self.pokemonSpecies = pokemonSpeciesProvider.providedPokemonSpecies
        default:
            break
        }
    }
}


// MARK: - Pokemon Species Provider

protocol PokemonSpeciesProvider {
    
    var providedPokemonSpecies: PokemonSpecies? { get }
    
}
