//
//  MovieSearchViewCodeController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 10/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

class MovieSerachViewCodeController: UIViewController {
    
    var movie = [Result]()
    //For system of search
    var filteredMovie = [Result]()
    var inSearchMode = false
    
    var isLoading = false
    var pageCount: Int = 1
    var totalPages: Int = 46
    
    var collectionViewDataSource: MovieSearchCollectionViewDataSource?
    var collectionViewDelegate: MovieSearchCollectionViewDelegate?
    
    var service: MovieService = MovieServiceImpl()
    
    let screen = MovieSearchView()
    
    override func loadView() {
        super.loadView()
        self.view = screen
        screen.delegate = self
    }
    
    
}
