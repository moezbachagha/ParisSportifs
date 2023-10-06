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
    var isSearching = false
    var LeaguesViewModel: LeaguesViewModel!
    var LeaguesArray: [League] = []
    var filteredItems: [League] = []
    var TeamsItems: [Team] = []
    var league : League!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureFlowLayout()
        LeaguesViewModel = ParisSportifs.LeaguesViewModel()
        LeaguesViewModel.getLeagues { [weak self] (Leagues, error) in
            if let error = error {
                
            }
            
            if let Leagues = Leagues {
                
                self?.LeaguesArray = Leagues
                self?.LeaguesCollection.reloadData()
                
                
                
            }
            print("retrieved \(self!.LeaguesArray.count) Leagues")
            
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredItems = LeaguesArray.filter { item in
            return item.strLeague!.lowercased().contains(searchText.lowercased())
        }
        
        if filteredItems.count == 1 {
            
            let  LeagueTeam = filteredItems.first?.strLeague
            
            LeaguesViewModel.getTeamsByLeague(LeagueTeam : LeagueTeam ?? " " , completion:  { [weak self] (Teams, error) in
                if let error = error {
                    print(error)
                    
                }
                
                if let Teams = Teams {
                    self?.TeamsItems = []
                    self?.TeamsItems = Teams
                    self?.TeamsItems.sort { $0.strTeam! > $1.strTeam! }
                    self?.LeaguesCollection.reloadData()
                    
                    
                    
                }
                print("retrieved \(self!.TeamsItems.count) Teams")
                
            })
            
            
        }
        else {
            self.TeamsItems = []
            print(filteredItems)
            self.LeaguesCollection.reloadData()
            
        }
        
    }
    func configureFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LeaguesCollection.frame.width - 20) / 2, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Adjust the section insets
        LeaguesCollection.collectionViewLayout = layout
    }
    
    
    
}





extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredItems.count > 1 {
            return  filteredItems.count
        }
        else if filteredItems.count == 1{
            return TeamsItems.count
            
        }
        else {
            return LeaguesArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        
        if filteredItems.count > 1 {
            league = filteredItems[indexPath.row]
            cell.titleLabel.text = league.strLeague
            cell.imageView.image = UIImage(named: "league")
        }
        
        else if filteredItems.count == 1{
            let team = TeamsItems[indexPath.row]
            cell.titleLabel.text = team.strAlternate
            if (team.strTeamLogo != nil) {
                if let imageURL = URL(string: team.strTeamBadge!) {
                    LeaguesViewModel.getImage(from : imageURL , completion: { [weak self] (image, error) in
                        if let error = error {
                            
                        }
                        
                        if let image = image {
                            DispatchQueue.main.async() { [weak self] in
                                cell.imageView.image = image
                                cell.imageView.layer.cornerRadius = 10
                                cell.imageView.clipsToBounds = true
                                cell.imageView.layer.shadowColor = UIColor.black.cgColor
                                cell.imageView.layer.shadowOpacity = 0.5
                                cell.imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
                                cell.imageView.layer.masksToBounds = false
                                cell.imageView.layer.shadowRadius = 5.0
                                
                            } }})
                    
                }}
            
            
        }
        else{
            league = LeaguesArray[indexPath.row]
            cell.titleLabel.text = league.strLeague
            cell.imageView.image = UIImage(named: "league")
            
            
        }
        
        
        
        return cell
    }
    
    
    
    
    
}
