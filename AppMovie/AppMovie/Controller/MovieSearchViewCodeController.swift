//
//  MovieSearchViewCodeController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 10/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchViewCodeController: UIViewController {
    
    var movie = [Result]()
    //For system of search
    var filteredMovie = [Result]()
    var inSearchMode = false
    
    var isLoading = false
    var pageCount: Int = 1
    var totalPages: Int = 46
    
    var collectionViewDataSource: MovieSearchCollectionViewDataSource?
    var collectionViewDelegate: MovieSearchCollectionViewDelegate?
    
    var movieSearchViewModel = MovieSearchViewModel()
    
    var service: MovieService = MovieServiceImpl()
    
    let screen = MovieSearchView()
    
    //Mark: - Init
    override func loadView() {
        super.loadView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiHandler()
        configureViewComponents()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupCollectionView(with: self.movie)
    }
    
    /*SetupView Inject Dependence(MOCKS...)
     func setupView(service: MovieService){
     self.service = service
     }*/
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Movies"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Search
        screen.search.barTintColor = UIColor.mainColor()
        screen.search.tintColor = UIColor.mainDarkBlue()
        screen.search.showsCancelButton = false
        for v:UIView in screen.search.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = UIColor.mainOrange()
            }
        }
    }
    
    // MARK: - SETUP COLLECTIONVIEW
    func setupCollectionView(with movies: [Result]){
        let checkedMovies = checkIsFavoriteMovie(movies: movies)
        collectionViewDataSource = MovieSearchCollectionViewDataSource(movies: checkedMovies, collectionView: screen.collection, delegate: self)
        collectionViewDelegate = MovieSearchCollectionViewDelegate(movies: checkedMovies, delegate: self)
        
        screen.collection.dataSource = collectionViewDataSource
        screen.collection.delegate = collectionViewDelegate
        screen.collection.reloadData()
    }
    
    // MARK - Verify FROM  Coredata  IS FAVORITE
    func checkIsFavoriteMovie(movies: [Result]) -> [Result] {
        // favoriteMovies.removeAll()
        var checkedMovies = movies
        let manegerCoreData = ManegerCoreData()
        
        for i in 0..<checkedMovies.count {
            let isFavorite = manegerCoreData.checkFavoriteMovie(movieId: "\(checkedMovies[i].id)")
            if (isFavorite == true){
                checkedMovies[i].setIsFavorite()}
        }
        return checkedMovies
    }
    
    // MARK: - API Services
    func apiHandler(){
        movieSearchViewModel.apiFromViewModel(page: pageCount){
        (movies) in
            DispatchQueue.main.async {
                self.movie.append(contentsOf: movies)
                self.setupCollectionView(with: movies)
            }
        }
    }
    
    
    func apiWithQueryHandler(query: String){
        movieSearchViewModel.apiWithQuery(query: query){
            (movies) in
            self.isLoading = false
                if(movies.isEmpty){
                    self.EmptyTextField(text: "Not Found", message: "Filme não encontrado na lista de filmes Populares")
                    DispatchQueue.main.async {
                        self.setupCollectionView(with: self.movie)
                    }
                    return
                }
                self.setupCollectionView(with: movies)
           
        }
    }
}

// MARK: - Protocol MOVIE SELECTION DELEGATE
extension MovieSearchViewCodeController: MovieSelectionDelegate{
    func didSelect(movie: Result) {
        
        let controller = MovieDetailViewCodeController()
        controller.movieCell = movie
        self.navigationController?.pushViewController(controller, animated: true)
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
        //            fatalError("should be a controller of type MovieDetailViewController")
        //        }
        //
        //        controller.movieCell = movie
        //        navigationController?.pushViewController(controller, animated: true)
    }
    func removeMovie(atIndexPath: IndexPath) {}
}

// MARK: - Protocol Delegate Paging
extension MovieSearchViewCodeController: MoviePagingDelegate{
    func loadMovies() {
        print("LoadMovies")
        pageCount += 1
        print(pageCount)
        if (inSearchMode == false){
            apiHandler()
        }
    }
}

// MARK: - UISearchDelate
extension MovieSearchViewCodeController: UISearchBarDelegate{
    func setupSearchBar() {
        self.screen.search.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        screen.search.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            print(query)
            apiWithQueryHandler(query: query)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        screen.search.showsCancelButton = false
        print("Cancel")
        self.setupCollectionView(with: self.movie)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            inSearchMode = false
            self.setupCollectionView(with: self.movie)
        } else {
            screen.search.showsCancelButton = true
            inSearchMode = true
            print(searchText)
            filteredMovie = movieSearchViewModel.movie.filter({ $0.title?.lowercased().range(of: searchText.lowercased()) != nil })
            //filter({$0.title.lowercased().contains(searchText.lowercased())})
            print(filteredMovie)
            self.setupCollectionView(with: self.filteredMovie)
        }
    }
    
}
