//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by KO TING on 3/5/2017.
//  Copyright © 2017年 EdUHK. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    //data pass from the viewController
    var pokemon: Pokemon!
    
    

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //using the data in the segue performing Passing Data
        nameLbl.text = pokemon.name.capitalized
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }



}
