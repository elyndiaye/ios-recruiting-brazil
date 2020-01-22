//
//  MovieSearchViewModel.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 21/01/20.
//  Copyright © 2020 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchViewModel {
    typealias completionBlock = ([Result]) -> ()
    var movie = [Result]()
    var filteredMovie = [Result]()
    
    var service: MovieService = MovieServiceImpl()
    
    func apiFromViewModel(page: Int, completionBlock : @escaping completionBlock){
        service.getMovies(page: page){ [weak self] movies in
            guard let self = self else { return }
            self.movie.append(contentsOf: movies)
            completionBlock(self.movie)
            
        }
    }
    
    func apiWithQuery(query: String, completionBlock : @escaping completionBlock){
        service.getMoviesByQuery(query: query){ [weak self] movies in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.filteredMovie += movies
                if(movies.isEmpty){
                    completionBlock(self.movie)
                    return
                }
                completionBlock(self.filteredMovie)
            }
        }
    }
    
    
    
    
}
