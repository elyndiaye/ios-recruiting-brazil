//
//  Movies.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page, total_results, total_pages: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
   
    let id: Int32
    let title: String?
    let poster_path: String?
    let original_language: String?
    let genre_ids: [Int]?
    let overview: String?
    let release_date: String?
    var isFavorite: Bool? = false
    
    
  
    
    //MARK: - Mutating Methods
    mutating func setIsFavorite() {
        self.isFavorite = true
    }
}
