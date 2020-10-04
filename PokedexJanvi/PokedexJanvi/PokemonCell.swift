//
//  PokemonCell.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/1/20.
//

import UIKit

class PokemonCell: UICollectionViewCell {

    
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func awakeFromNib() { 
        super.awakeFromNib()
        // Initialization code
    }
    

}
