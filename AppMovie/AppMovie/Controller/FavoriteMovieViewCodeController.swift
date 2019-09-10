//
//  FavoriteMovieViewCodeController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FavoriteMovieViewCodeController: UIViewController {
    
    
    var movies: [MovieEntity] = []
    var inSearchMode = false
    var filteredMovieFromEntity = [MovieEntity]()
    
    var tableViewDataSource: FavoriteMovieTableViewDataSource?
    var tableViewDelegate: FavoriteMovieTableViewDelegate?
    
    let screen = FavoriteMoviesView()
    
    override func loadView() {
        super.loadView()
        self.view = screen
    }
    
    //MARK: -INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCoreDataObjects()
        self.setupTableView(with: self.movies)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewComponents()
        //        screen.activityIndicator.isHidden = false
        //        screen.activityIndicator.startAnimating()
        screen.table.isHidden = true
    }
    
    //MARK - CALL FETCH BY COREDATA
    func fetchCoreDataObjects() {
        let manegerCoreData = ManegerCoreData()
        manegerCoreData.fetch(MovieEntity.self, successCompletion: { (movieEntity) in
            //            self.activityIndicator.stopAnimating()
            //            self.activityIndicator.isHidden = true
            self.movies = movieEntity
            if self.movies.count >= 1 {
                self.screen.table.isHidden = false
            } else {
                self.screen.table.isHidden = true
            }
            
        }) { (error) in
            print("Could't load favorite movies.")
            self.screen.table.isHidden = true
        }
    }
    
    //MARK - SETUP TABLEVIEW
    func setupTableView(with movie: [MovieEntity]) {
        tableViewDataSource = FavoriteMovieTableViewDataSource(movies: movie, tableView: screen.table)
        tableViewDelegate = FavoriteMovieTableViewDelegate(movies: movie, delegate: self)
        
        screen.table.dataSource = tableViewDataSource
        screen.table.delegate = tableViewDelegate
        screen.table.reloadData()
    }
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Favoritos"
        self.tabBarController?.tabBar.isHidden = false
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Search
        screen.search.barTintColor = UIColor.mainColor()
        screen.search.tintColor = UIColor.mainOrange()
        screen.search.showsCancelButton = false
        for v:UIView in screen.search.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = UIColor.mainOrange()
            }
        }
    }
    
}

//MARK: - CoreData PROTOCOLO SELECTION DELEGATE REMOVE AND CLICK DETAILS
extension FavoriteMovieViewCodeController: MovieSelectionDelegate{
    
    func didSelect(movie: Result) {
        let controller = MovieDetailViewCodeController()
        controller.movieCell = movie
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func removeMovie(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(movies[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        tableViewDataSource?.movies.remove(at: indexPath.row)
        self.fetchCoreDataObjects()
        
    }
    
}

extension FavoriteMovieViewCodeController: UISearchBarDelegate{
    func setupSearchBar() {
        self.screen.search.delegate = self
        print("SEARCH ")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        screen.search.showsCancelButton = false
        print("Cancel")
        self.setupTableView(with: self.movies)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            inSearchMode = false
            self.setupTableView(with: self.movies)
        } else {
            screen.search.showsCancelButton = true
            inSearchMode = true
            print(searchText)
            filteredMovieFromEntity = movies.filter({ $0.movieTitle?.lowercased().range(of: searchText.lowercased()) != nil })
            //filter({$0.title.lowercased().contains(searchText.lowercased())})
            print(filteredMovieFromEntity)
            if verifyisContainsTheMovie(){
                EmptyTextField(text: "Not Found", message: "Filme não encontrado na lista de favoritos")
                self.setupTableView(with: self.movies)
                return
            }
            self.setupTableView(with: self.filteredMovieFromEntity)
        }
    }
    
    func verifyisContainsTheMovie() -> Bool {
        return filteredMovieFromEntity.isEmpty
    }
    
    
}
