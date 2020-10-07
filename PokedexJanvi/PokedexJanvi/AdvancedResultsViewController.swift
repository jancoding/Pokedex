//
//  AdvancedResultsViewController.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/6/20.
//

import UIKit

class AdvancedResultsViewController: UIViewController {
    var typeList = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var typeSelected: [Bool]!
    var pokemonList: [Pokemon]!
    var categoryFilteredPokemon: [Pokemon]!
    var currentIndexPath: IndexPath!
    var isGrid = false

    
    var minAttackPoints, minDefensePoints, minHealthPoints, maxHealthPoints, maxAttackPoints, maxDefensePoints: Int!
    var isRandom: Bool!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryFilterPokemon()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 212, height: 100)
        collectionView.collectionViewLayout = layout
        
        self.navigationItem.title = "Pokemon Advanced Results"

        // Do any additional setup after loading the view.
    }
    @IBAction func switchGridView(_ sender: Any) {
        if !isGrid{
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 150, height: 100)
            collectionView.collectionViewLayout = layout
            isGrid = true
        }
        else{
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 212, height: 100)
            collectionView.collectionViewLayout = layout
            isGrid = false
        }
        
        
    }
    
    func categoryFilterPokemon() {
        categoryFilteredPokemon = pokemonList
        for i in 0..<typeSelected.count {
            if typeSelected[i] {
                categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.types.contains(PokeType(rawValue: typeList[i])!) }
            }
        }
        categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.attack >= minAttackPoints && $0.attack <= maxAttackPoints}
        categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.defense >= minDefensePoints && $0.defense <= maxDefensePoints}
        categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.health >= minHealthPoints && $0.health <= maxHealthPoints}
    }
    


}

extension AdvancedResultsViewController: UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return categoryFilteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell
        let pokemon: Pokemon

        pokemon = categoryFilteredPokemon[indexPath.row]

        cell!.pokemonName.text = pokemon.name
        cell!.pokemonNumber.text = String(pokemon.id)
        
        guard let url = URL(string: pokemon.imageUrl) else {
            let image = UIImage(named: "question_mark")
            cell!.pokemonImage.image = image
            return cell!
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                cell!.pokemonImage.image = image
            }
        }
        return cell!
    }
    
    
}

extension AdvancedResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currentIndexPath = indexPath
        self.performSegue(withIdentifier: "advsearchToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProfileViewController
        destinationVC.pokemon = categoryFilteredPokemon[currentIndexPath.row]
        destinationVC.pokemonList = pokemonList
    }
    
}
