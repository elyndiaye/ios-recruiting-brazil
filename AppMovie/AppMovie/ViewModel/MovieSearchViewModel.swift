//
//  MovieSearchViewModel.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 21/01/20.
//  Copyright © 2020 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

public class MovieSearchViewModel {
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
        service.getMoviesByQuery(query: query){ [weak self] moviesFiltred in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.filteredMovie += moviesFiltred
//                if(movies.isEmpty){
//                    completionBlock(self.filteredMovie)
//                    return
//                }
                completionBlock(self.filteredMovie)
            }
        }
    }
    
    
    
    
}
