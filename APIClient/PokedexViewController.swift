//
//  ViewController.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Moya


class PokedexViewController: UITableViewController, PokemonSpeciesProvider {
    
    /// The Poke API provider that handles requests for server resources
    var pokeAPI: MoyaProvider<PokeAPI>!

    /// The Pokedex to show here
    var pokedex: Pokedex! {
        didSet {
            // Obtain the entries of the Pokedex and prepare the `pokemonSpecies` and `sprites` arrays to hold loaded resources
            self.pokemonSpecies = pokedex.entries.map({ .notLoaded(.pokemonSpecies($0.pokemonSpecies)) })
            self.sprites = pokedex.entries.map({ _ in nil })
            // Configure the view
            self.title = pokedex.localizedName
            self.tableView.reloadData()
        }
    }
    /// Holds the resource for each row of the table view that may or may not be loaded yet
    private var pokemonSpecies: [APIResource<PokeAPI, PokemonSpecies>] = []
    /// Holds the image information for each row of the table view that may or may not be loaded yet
    private var sprites: [APIResource<PokeAPI, Pokemon>?] = []
    
    /// Holds the selected Pokemon species to provide to segue destination
    var providedPokemonSpecies: PokemonSpecies?
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    
    // MARK: User Interaction
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Retry to load a resource if it failed before
        if case .failed(let target, _) = pokemonSpecies[indexPath.row] {
            self.pokemonSpecies[indexPath.row] = .notLoaded(target)
            tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
        }
        if let sprite = sprites[indexPath.row], case .failed(let target, _) = sprite {
            self.sprites[indexPath.row] = .notLoaded(target)
            tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        switch identifier {
        case "showPokemonSpecies":
            if let indexPath = tableView.indexPathForSelectedRow, case .loaded = pokemonSpecies[indexPath.row] {
                return true
            } else {
                return false
            }
        default:
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "showPokemonSpecies":
            guard let indexPath = tableView.indexPathForSelectedRow, case .loaded(let pokemonSpecies) = pokemonSpecies[indexPath.row] else {
                return
            }
            self.providedPokemonSpecies = pokemonSpecies
        default:
            break
        }
    }
}


// MARK: - Table View Datasource

extension PokedexViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonSpecies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Load the resource for this row if necessary
        if case .notLoaded(let target) = pokemonSpecies[indexPath.row] {
            pokemonSpecies[indexPath.row] = pokeAPI.request(target) { result in
                self.pokemonSpecies[indexPath.row] = result
                // Obtain the image information from a loaded resource to be loaded subsequentially
                if case .loaded(let pokemonSpecies) = result {
                    self.sprites[indexPath.row] = pokemonSpecies.varieties.first.flatMap({ .notLoaded(.pokemon($0)) })
                }
                tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
            }
        }
        
        // Load the image information for this row if necessary
        if let sprite = sprites[indexPath.row], case .notLoaded(let target) = sprite {
            sprites[indexPath.row] = pokeAPI.request(target) { result in
                self.sprites[indexPath.row] = result
                tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
            }
        }
        
        // Obtain a cell and configure it
        let cell = tableView.dequeueReusableCellWithIdentifier("PokemonSpeciesCell", forIndexPath: indexPath) as! PokemonSpeciesCell
        cell.configureForEntry(pokedex.entries[indexPath.row], pokemonSpecies: pokemonSpecies[indexPath.row], sprite: sprites[indexPath.row])
        if case .loaded = pokemonSpecies[indexPath.row] {
            cell.selectionStyle = .Default
        } else {
            cell.selectionStyle = .None
        }
        return cell
    }
    
}
