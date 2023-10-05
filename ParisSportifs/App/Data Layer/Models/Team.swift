//
//  Team.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import Foundation
struct Team: Decodable {
    
    
    
       
        let idTeam: String?
        let strTeam: String?
        let strAlternate: String?
        let strLeague: String?
        let strStadium: String?
        let strStadiumThumb: String?
        let strStadiumDescription: String?
        let intStadiumCapacity: String?
        let strTeamLogo: String?
        let strTeamBadge: String?
        let strDescriptionFR: String?
    
        
        enum CodingKeys: String, CodingKey {
            case idTeam
            case strTeam
            case strAlternate
            case strLeague
            case strStadium
            case strStadiumThumb
            case strStadiumDescription
            case intStadiumCapacity
            case strTeamLogo
            case strTeamBadge
            case strDescriptionFR
        
          
        
    }
    }

