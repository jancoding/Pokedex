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
    let sectionInsets = UIEdgeInsets(top:20.0, left:10.0, bottom:20.0, right:10.0)
    let itemsPerRow: CGFloat = 3
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    
    var isGrid = false
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
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 212, height: 100)
        pokemonCollectionView.collectionViewLayout = layout
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "searchToAdvSearch":
            let destinationVC = segue.destination as! AdvancedSearchViewController
            destinationVC.pokemonList = pokemonList
        case "searchToProfile":
            let destinationVC = segue.destination as! ProfileViewController
            if isFiltering() {
                destinationVC.pokemon = filteredPokemon[currentIndexPath.row]
            } else {
                destinationVC.pokemon = pokemonList[currentIndexPath.row]
            }
            destinationVC.pokemonList = pokemonList
        default: break
        }
    }
    
    @IBAction func switchGrid(_ sender: Any) {
        if !isGrid{
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 150, height: 100)
            pokemonCollectionView.collectionViewLayout = layout
            isGrid = true
        }
        else{
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 212, height: 100)
            pokemonCollectionView.collectionViewLayout = layout
            isGrid = false
        }
        
    }
    
    
    @IBAction func advancedSearchedTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "searchToAdvSearch", sender: self)
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




