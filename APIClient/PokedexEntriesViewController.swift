//
//  PokedexEntriesViewController.swift
//  APIClient
//
//  Created by Nils Fischer on 22.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Moya

class PokedexEntriesViewController: UITableViewController {
    
    /// The Poke API provider that handles requests for server resources
    var pokeAPI: MoyaProvider<PokeAPI>!
    
    /// The Pokemon species whose Pokedex entries to show here
    var pokemonSpecies: PokemonSpecies! {
        didSet {
            self.title = pokemonSpecies.localizedName
            self.pokedexes = pokemonSpecies.pokedexEntries.map { entry in
                return .notLoaded(.pokedex(entry.pokedex))
            }
        }
    }
    /// Holds the resource for each row of the table view that may or may not be loaded yet
    var pokedexes: [APIResource<PokeAPI, Pokedex>]!
 
    
    // MARK: User Interaction
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        switch identifier {
        case "showPokedex":
            if let indexPath = tableView.indexPathForSelectedRow, case .loaded = pokedexes[indexPath.row] {
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
        case "showPokedex":
            guard let pokedexViewController = segue.destinationViewController as? PokedexViewController else {
                return
            }
            guard let indexPath = tableView.indexPathForSelectedRow, case .loaded(let pokedex) = pokedexes[indexPath.row] else {
                return
            }
            pokedexViewController.pokeAPI = pokeAPI
            pokedexViewController.pokedex = pokedex
        default:
            break
        }
    }
    
}


// MARK: - Table View Datasource

extension PokedexEntriesViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonSpecies.pokedexEntries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Load the resource for this row if necessary
        if case .notLoaded(let target) = pokedexes[indexPath.row] {
            pokedexes[indexPath.row] = pokeAPI.request(target) { result in
                self.pokedexes[indexPath.row] = result
                tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
            }
        }
        
        // Obtain a cell and configure it
        let cell = tableView.dequeueReusableCellWithIdentifier("PokedexEntryCell", forIndexPath: indexPath) as! PokedexEntryCell
        cell.configureForEntry(pokemonSpecies.pokedexEntries[indexPath.row], pokedex: pokedexes[indexPath.row])
        if case .loaded = pokedexes[indexPath.row] {
            cell.selectionStyle = .Default
            cell.accessoryType = .DisclosureIndicator
        } else {
            cell.selectionStyle = .None
            cell.accessoryType = .None
        }
        return cell
    }
    
}
