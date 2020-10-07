//
//  SearchVC-CollectionView.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/1/20.
//

import UIKit

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPokemon.count
        }
        return pokemonList.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell
        let pokemon: Pokemon
        
        if isFiltering() {
            pokemon = filteredPokemon[indexPath.row]
        } else {
            pokemon = pokemonList[indexPath.row]
        }
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
    
    


extension SearchVC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currentIndexPath = indexPath
        self.performSegue(withIdentifier: "searchToProfile", sender: self)
    }
}


/*
extension SearchVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0

        return CGSize(width: yourWidth, height: 50)
    }

   
}
 */
 
 
