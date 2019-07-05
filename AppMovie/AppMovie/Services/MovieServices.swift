//
//  MovieServices.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class MovieServices {
    
    static let instance = MovieServices()
    
    var movies = [Movies]()
    
    func getMovies(completionHandler: @escaping ([Result]) -> Void ) {
        Alamofire.request(URL_NOWPLAYING, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayMovies = [Result]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedMovies = try decoder.decode(Movies.self, from: data)
                    //print(decodedMovies)
                    
                    completionHandler(decodedMovies.results)
                } catch let error {
                    print(error)
                    completionHandler(arrayMovies)
                    debugPrint(response.result.error as Any)
                }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
