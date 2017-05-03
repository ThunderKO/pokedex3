//
//  ViewController.swift
//  pokedex3
//
//  Created by KO TING on 3/5/2017.
//  Copyright © 2017年 EdUHK. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    
    //filter pokemon array for the search bar
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //connecting to the UICollectionViewCell in the VC
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    //init the audio (get the music ready)
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    //pass the csv data
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                //unwrap the data in the csv file
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                //Creat the poke obj and append to the Pokemon array
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
            //loop throw the rwo and show the data
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            //Creating the pokemon obj in the collection View Cell
            let poke: Pokemon!
            //
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
            //Use the configure function we created before and use it for the corresponding pokemon cell (name and the image)
            cell.configureCell(poke)
            //reuseable cell showing what is needed to display, picking up another cell for showing other cell
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        if  inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        //sending the poke!
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        //every reuseable cell's number
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //each small cell's unit
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //define the size of the cell
        return CGSize(width: 105, height: 105)
    }

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    //call the function when there are text on it!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            //if deleted the data in the bar and refresh
            collection.reloadData()
            //the keyboard setting
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            //The filter pokemon list is equal to the original pokemon array but in the filter mode, the "$0" is placeholder for every obj in the pokemon array. Taking the name value and filter it whether the filter bar text is in the range of the name of the pokemon in the original array of the pokemon.
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            //Reload the collection data in the collection view
            collection.reloadData()
        }
     }
    
    //prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            //Create a variable for the detail view controller
            if let detailsVC = segue.destination as? PokemonDetailVC {
                //as a class of Pokemon
                if let poke = sender as? Pokemon {
                    //in the detail view controller (detailsVC. pokemon) will the variable for the data that we pass.
                    detailsVC.pokemon = poke
                }
            }
        }
    }

}

