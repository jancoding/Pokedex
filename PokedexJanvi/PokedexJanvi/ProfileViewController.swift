//
//  ProfileViewController.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/6/20.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var pokemon: Pokemon!
    var pokemonStats: [Int]!
    var pokemonTypes: [String]!
    var pokemonSpeed: Int!
    var pokemonStatisticsNames = ["Total", "Health", "Attack","Defense", "Special Attack","Special Defense", "Total"]
    var pokemonList: [Pokemon]!

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = pokemon.name
        pokemonNumber.text = String(pokemon.id)
        print("HERE")
        pokemonStats = [pokemon.total, pokemon.health, pokemon.attack, pokemon.defense, pokemon.specialAttack, pokemon.specialDefense]
        pokemonSpeed = pokemon.speed
        print("HERE")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        guard let url = URL(string: pokemon.imageUrl) else {
            let image = UIImage(named: "question_mark")
            pokemonImage.image = image
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            pokemonImage.image = image
        } catch {
            let image = UIImage(named: "question_mark")
            pokemonImage.image = image
        }
        
        self.navigationItem.title = "Profile"

        // Do any additional setup after loading the view.
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



extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("HIIIIII")
        return pokemonStats.count + 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("HELLLLOOOO")
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
        if indexPath.row < pokemonStats.count {
            cell.statisticsName.text = pokemonStatisticsNames[indexPath.row]
            cell.statistic.text = String(pokemonStats[indexPath.row])
        } else if indexPath.row == pokemonStats.count {
            cell.statisticsName.text = "Type(s)"
            var typeStatistic = ""
            for type in pokemon.types {
                typeStatistic += type.rawValue + " "
            }
            cell.statistic.text = typeStatistic
        } else {
            cell.statisticsName.text = "Speed"
            cell.statistic.text = String(pokemonSpeed)
        }
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}



