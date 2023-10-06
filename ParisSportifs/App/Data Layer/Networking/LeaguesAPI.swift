//
//  LeaguesAPI.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import Foundation
import Alamofire

typealias LeagueListAPIResponse = (Swift.Result<[League]?, DataError>) -> Void
typealias TeamsByLeagueAPIResponse = (Swift.Result<[Team]?, DataError>) -> Void

var Leagues : [League]  = []
var Teams : [Team]  = []


// API interface to retrieve city

protocol LeaguesAPILogic {
    func getLeagues(completion: @escaping (LeagueListAPIResponse))
    func getTeamsByLeague(LeagueTeam : String,  completion: @escaping (TeamsByLeagueAPIResponse))
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
            Leagues  = []
            
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
    
    
    func getTeamsByLeague(LeagueTeam : String ,completion: @escaping (TeamsByLeagueAPIResponse)) {
        
        
        let inputString = LeagueTeam
        
        
        
        // Define the base URL without the parameters
        let baseURL = "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php"
        
        // Create a dictionary to hold your parameters
        
        
        // Append the parameters to the URL
        // Encode the string
        if let encodedString = inputString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            print(encodedString) // Output: "English%20Premier%20League"
            let parameters: [String: Any] = ["l": encodedString]
            let urlWithParameters = baseURL + "?" + parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            
            
            
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json; charset=utf-8",
            ]
            
            AF.request(urlWithParameters , method: .get, parameters: nil, encoding : URLEncoding.httpBody, headers: headers)
                .validate()
                .responseJSON
            { [self]
                response in
                
                Teams  = []
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let value):
                    if let JSON = value as? [String: Any] {
                        if  JSON.count != 0{
                            let results = JSON["teams"] as? [[String: Any]]
                            results?.forEach{
                                
                                do {
                                    
                                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                                    do {
                                        let Team = try JSONDecoder().decode(Team.self, from: jsonData)
                                        
                                        Teams.append(Team)
                                    }
                                    
                                    catch {
                                        
                                        print("Error decoding JSON: \(error)")
                                    }}
                                
                                catch {
                                    
                                    print("Error converting dictionary to JSON data: \(error)")
                                    
                                    
                                }}
                            completion(.success(Teams))
                            
                        }
                        
                    }
                }
            }
            
            
        } else {
            print("Encoding failed")
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
