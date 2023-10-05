//
//  ViewController.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var LeaguesCollection: UICollectionView!
    
    var LeaguesViewModel: LeaguesViewModel!
    var LeaguesArray: [League] = []
    var filteredItems: [League] = []
    var league : League!


    override func viewDidLoad() {
        
        super.viewDidLoad()
     //   LeaguesCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        LeaguesViewModel = ParisSportifs.LeaguesViewModel()
        LeaguesViewModel.getLeagues { [weak self] (Leagues, error) in
            if let error = error {
               
            }
            
            if let Leagues = Leagues {
                
                self?.LeaguesArray = Leagues
             //   print(Leagues)
                self?.LeaguesCollection.reloadData()


                
            }
            print("retrieved \(self!.LeaguesArray.count) Leagues")

        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredItems = LeaguesArray.filter { item in
            return item.strLeague!.lowercased().contains(searchText.lowercased())
        }
        print(filteredItems)
        self.LeaguesCollection.reloadData()
    }
    }





extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredItems.count > 0 {
            return  filteredItems.count
        }
        else {
            return LeaguesArray.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

            
                  if filteredItems.count > 0 {
                     league = filteredItems[indexPath.row]
                           }
                      else {
                    league = LeaguesArray[indexPath.row]

                     }
                    cell.titleLabel.text = league.strLeague!
       
       
            
            return cell
        }
    
   
    
}
