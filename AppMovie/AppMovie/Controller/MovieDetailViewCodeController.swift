//
//  MovieDetailViewCodeController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 31/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit
import CoreData


final class MovieDetailViewCodeController: UIViewController{
    
    var genero: String!
    var movieCell : Result?
    
    let screen = MovieDetailView()
    
    override func loadView() {
        super.loadView()
        self.view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        configureComponents()
    }
    
    func configureComponents() {
        guard let movieCell = self.movieCell else {
            screen.titulo.text = "Error on Movie"
            navigationItem.title = "Error"
            return
        }
        
        screen.titulo.text = movieCell.title
        screen.dateLabel.text = movieCell.release_date
        screen.descriptionTxtView.text = movieCell.overview!.isEmpty ? "No description" : movieCell.overview
        
        configureGenersId()
        screen.geners.text = genero
        
        screen.imageView.kf.indicatorType = .activity
        guard let stringImage = movieCell.poster_path else {return}
        let Image = "\(URL_IMG)\(stringImage)"
        screen.imageView.download(image: Image )
        
        if (movieCell.isFavorite == true){
            self.screen.ButtonFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }
        
        //      screen.ButtonFavorite.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
    }
    
    func configureGenersId(){
        guard let geners = movieCell?.genre_ids else {return}
        if geners.isEmpty {return genero = "Unknow"}
        switch(geners[0]){
        case (28):
            genero = "Action"
        case (12):
            genero = "Adventure"
        case (16):
            genero = "Animation"
        case (35):
            genero = "Comedy"
        case (80):
            genero = "Crime"
        case (99):
            genero = "Documentary"
        case (18):
            genero = "Drama"
        case (10751):
            genero = "Family"
        case (14):
            genero = "Fantasy"
        case (36):
            genero = "History"
        case (27):
            genero = "Horror"
        case (10402):
            genero = "Music"
        case (9648):
            genero = "Mystery"
        case (10749):
            genero = "Romance"
        case (878):
            genero = "Science Fiction"
        case (10752):
            genero = "War"
        case (10752):
            genero = "War"
        default:
            genero = "Unknow"
        }
    }
    
    private func bindToMovieEntity(_ movie: Result) -> MovieEntity {
        let movieEntity = MovieEntity(context: getCoreDataContext())
        movieEntity.moveId = movie.id
        movieEntity.movieDescription = movie.overview
        movieEntity.movieTitle = movie.title
        movieEntity.movieDate = movie.release_date
        movieEntity.movieImage = movie.poster_path
        movieEntity.movieIsFavorite = true
        
        return movieEntity
    }
    
    func getCoreDataContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}

//MARK - PROTOCOL pressFavoriteBtn
extension MovieDetailViewCodeController: MovieFavoriteDelegate{
    func pressFavoriteBtn() {
        guard let movie = movieCell else {return}
        let manegerCoreData = ManegerCoreData()
        if (movie.isFavorite != true){
            manegerCoreData.save(bindToMovieEntity(movie), successCompletion: {
                self.screen.ButtonFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
                self.movieCell?.isFavorite = true
                self.EmptyTextField(text: "Adicionado", message: "Este filme foi adicionado aos favoritos!")
            }) { (error) in
                self.screen.ButtonFavorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
                self.EmptyTextField(text: "Errroouuu", message: "Este filme não foi adicionado aos favoritos!")
            }
        }
        else { self.EmptyTextField(text: "Ja adicionado", message: "Este filme já está adicionado aos favoritos!") }
    }
    
}
