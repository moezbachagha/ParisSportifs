//
//  LeaguesViewModel.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import Foundation
import UIKit

class LeaguesViewModel {
    
private(set) var Leagues: [League] = []
private(set) var error: DataError? = nil

private let apiService: LeaguesAPILogic

    init(apiService: LeaguesAPILogic = LeaguesAPI()) {
        self.apiService = apiService
    }
    
    
func getLeagues(completion: @escaping( ([League]?, DataError?) -> () ) ) {
    apiService.getLeagues { [weak self] result in
        
        switch result {
        case .success(let Leagues):
            self?.Leagues = Leagues ?? []
            completion(Leagues, nil)
        case .failure(let error):
            self?.error = error
            completion(nil, error)
        }
    }
}
   
                         
    
    
    func getImage(from url: URL, completion: @escaping( (UIImage?)?, DataError?) -> () )  {
        apiService.downloadImage (from : url,
            completion: { [weak self] result in
            if let image = result {
                completion(image, nil)
                    }
            else {
                
                completion(nil, DataError.invalidData)
            }
        }
        )
    }
    
}
