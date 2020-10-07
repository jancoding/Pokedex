//
//  PokemonCell.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/1/20.
//

import UIKit

class PokemonCell: UICollectionViewCell {

    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
