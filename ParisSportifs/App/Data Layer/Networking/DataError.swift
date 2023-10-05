//
//  DataError.swift
//  ParisSportifs
//
//  Created by Moez bachagha on 5/10/2023.
//

import Foundation

enum DataError: Error {
    case networkingError(String)
    case invalidData

}
