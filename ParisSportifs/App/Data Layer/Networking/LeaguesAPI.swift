//
//  LeaguesAPI.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import Foundation
import Alamofire

typealias LeagueListAPIResponse = (Swift.Result<[League]?, DataError>) -> Void
typealias LeagueDetailsAPIResponse = (Swift.Result<League?, DataError>) -> Void

var Leagues : [League]  = []

// API interface to retrieve city

protocol LeaguesAPILogic {
    func getLeagues(completion: @escaping (LeagueListAPIResponse))
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

class LeaguesAPI: LeaguesAPILogic {
  
    



    func getLeagues(completion: @escaping (LeagueListAPIResponse)) {
        

        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
        ]
       
        AF.request(Common.Leagues.All , method: .get, parameters: nil, encoding : URLEncoding.httpBody, headers: headers)
            .validate()
            .responseJSON
        { [self]
            response in
       
                
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let value):
                if let JSON = value as? [String: Any] {
                if  JSON.count != 0{
                let results = JSON["leagues"] as? [[String: Any]]
                            results?.forEach{
                                
                do {
                    
                let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    do {
                        let league = try JSONDecoder().decode(League.self, from: jsonData)
                        
                        Leagues.append(league)
                                }
                    
                              catch {
                                  
                        print("Error decoding JSON: \(error)")
                        }}
                                
                                catch {
                        
                        print("Error converting dictionary to JSON data: \(error)")
                                    
                                    
                    }}
                       completion(.success(Leagues))
                      
                        }
                        
                    }
                }
            }
    
 
        
    }
   
            
    
 
        
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
    

}
