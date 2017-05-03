//
//  PokeCell.swift
//  pokedex3
//
//  Created by KO TING on 3/5/2017.
//  Copyright © 2017年 EdUHK. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //call the pokemon class
    var pokemon: Pokemon!
    
    //ROUNDED CORNER for the pokemon cell
    
    //implementing the modifier
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //modifying
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
