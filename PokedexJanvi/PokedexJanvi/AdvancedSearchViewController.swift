//
//  AdvancedSearchViewController.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/6/20.
//

import UIKit

class AdvancedSearchViewController: UIViewController {
    var typeList = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var typeSelected = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    var pokemonList: [Pokemon]!
    
    @IBOutlet weak var minHealthPoints: UITextField!
    @IBOutlet weak var minAttackPoints: UITextField!
    @IBOutlet weak var minDefensePoints: UITextField!
    @IBOutlet weak var maxHealthPoints: UITextField!
    @IBOutlet weak var maxAttackPoints: UITextField!
    @IBOutlet weak var maxDefensePoints: UITextField!
    @IBOutlet weak var pokemonTypeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        pokemonTypeCollectionView.isScrollEnabled = false;
        self.navigationItem.title = "Category Search"

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "advSearchToList":
            let destinationVC = segue.destination as! AdvancedResultsViewController
            destinationVC.typeSelected = typeSelected
            destinationVC.pokemonList = pokemonList
            
            destinationVC.minAttackPoints = Int(minAttackPoints.text ?? "String") ?? 0
            destinationVC.minDefensePoints = Int(minDefensePoints.text ?? "String") ?? 0
            destinationVC.minHealthPoints = Int(minHealthPoints.text ?? "String") ?? 0
            destinationVC.maxHealthPoints = Int(maxHealthPoints.text ?? "String") ?? 0
            destinationVC.maxAttackPoints = Int(maxAttackPoints.text ?? "String") ?? 0
            destinationVC.maxDefensePoints = Int(maxDefensePoints.text ?? "String") ?? 0

            
            destinationVC.isRandom = false
        default: break
        }
    }
    
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
                
                for i in 0..<self.typeList.count {
                    if sender.currentTitle == self.typeList[i] {
                        self.typeSelected[i] = !self.typeSelected[i]
                        continue
                    }
                }
            }, completion: nil)
        }
    }
    
    
    @IBAction func categorySearchTapped(_ sender: Any) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "advSearchToList", sender: self)
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


extension AdvancedSearchViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return typeList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
            cell.typeButton.setTitle(typeList[indexPath.row], for: .normal)
            return cell
        }
}

extension AdvancedSearchViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
