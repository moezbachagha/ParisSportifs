//
//  MockLeagueAPI.swift
//  ParisSportifsTests
//
//  Created by Moez bachagha on 6/10/2023.
//

import Foundation
import UIKit
@testable import ParisSportifs


class MockLeagueAPI: LeaguesAPILogic {
  
    var loadState: LeaguesListLoadState = .empty
    
    
    func getLeagues(completion: @escaping (LeagueListAPIResponse)) {
        switch loadState {
        case .error:
            completion(.failure(.networkingError("Could not fetch Leagues")))
        case .loaded:
            let mockLeague = League(idLeague: "1234", strLeague: "Test", strSport: "Test", strLeagueAlternate: "Test")
            completion(.success([mockLeague]))
        case .empty:
            completion(.success([]))
        }
    }
    

    func getTeamsByLeague(LeagueTeam :String , completion: @escaping (TeamsByLeagueAPIResponse)) {
        
        
        switch loadState {
        case .error:
            completion(.failure(.networkingError("Could not fetch Team")))
        case .loaded:
            let mockTeam = Team(idTeam: "34", strTeam: "Test", strAlternate: "Test", strLeague: "Test", strStadium: "Test", strStadiumThumb: "Test", strStadiumDescription: "Test", intStadiumCapacity: "Test", strTeamLogo: "Test", strTeamBadge: "Test", strDescriptionFR: "Test")
            completion(.success([mockTeam]))
        case .empty:
            completion(.success(nil))
        }
    }
    
    
    
    
    
    
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        switch loadState {
        case .error:
            print(DataError.networkingError("Could not fetch Movie details"))
        case .loaded:
            print(DataError.networkingError("Could not fetch Movie details"))
        case .empty:
            print(DataError.networkingError("Could not fetch Movie details"))
        }
    }
        
    

}
