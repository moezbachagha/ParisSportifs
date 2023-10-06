//
//  League.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import Foundation

struct League: Decodable {
    
    
    
    
    let idLeague: String?
    let strLeague: String?
    let strSport: String?
    let strLeagueAlternate: String?
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case idLeague
        case strLeague
        case strSport
        case strLeagueAlternate
        
        
    }
}

