//
//  Model.swift
//  PosrRequest
//
//  Created by Marat Fakhrizhanov on 30.07.2024.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodinError
}

enum Link: String {
    case urlForRequest = "https://jsonplaceholder.typicode.com/posts"
}

struct Man: Codable {
    let name: String
    let surname: String
    let age: String
    }

