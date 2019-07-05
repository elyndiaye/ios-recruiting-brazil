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
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let vote_average: Double?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let original_language: OriginalLanguage?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
}

enum OriginalLanguage: String, Codable {
    case da = "da"
    case en = "en"
    case fr = "fr"
    case ja = "ja"
    case ko = "ko"
    case es = "es"
    case tl = "tl"
}
