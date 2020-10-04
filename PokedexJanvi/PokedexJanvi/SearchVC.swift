//
//  SearchVC.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/1/20.
//

import UIKit

class SearchVC: UIViewController{

    var pokemonList = PokemonGenerator.getPokemonArray().sorted(by: { $0.id < $1.id })
    let searchController = UISearchController(searchResultsController: nil)
    var currentIndexPath: IndexPath!
    var filteredPokemon = [Pokemon]()
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemonList)
        view.addSubview(pokemonCollectionView)
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        self.navigationItem.title = "Pokédex"

        // Do any additional setup after loading the view.
    }
    
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            return String(pokemon.id).contains(searchText) || pokemon.name.lowercased().contains(searchText.lowercased())
        })
        
        pokemonCollectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
