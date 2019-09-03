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
    
    var movieCell : Result?{
        didSet {
            
            titulo.text = movieCell?.title
            dateLabel.text = movieCell?.release_date
            descriptionTxtView.text = movieCell?.overview
                //.isEmpty ? "No description" : movieCell.overview
            //configureGenersId()
            geners.text = "Arrumar"
            
            imageView.kf.indicatorType = .activity
            //let stringImage = movie?.poster_path
            let stringImage = movieCell?.poster_path
            let Image = "\(URL_IMG)\(stringImage)"
            imageView.download(image: Image )
            
            
            if (movieCell?.isFavorite == true){
               print("true")
            }
        }
    }
    
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
   
    lazy var titulo: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Title"
        //view.backgroundColor = .white
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ButtonFavorite: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        view.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
        //view.backgroundColor = .white
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var separator: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = .lightGray
    return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Date"
        //view.backgroundColor = .white
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var separatorDateLabel: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var geners: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Geners"
        //view.backgroundColor = .white
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var separatorGenersLabel: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var descriptionTxtView: UITextView = {
        let view = UITextView(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Description........"
        return view
    }()
    
//    override init(frame: CGRect = .zero) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        setupView()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
     view.backgroundColor = .white
        setupView()
    }
}

extension MovieDetailViewCodeController: CodeView{
    func buildViewHierarchy() {
        //Adicionar View
        view.addSubview(imageView)
        view.addSubview(titulo)
        view.addSubview(ButtonFavorite)
        view.addSubview(separator)
        view.addSubview(dateLabel)
        view.addSubview(separatorDateLabel)
        view.addSubview(geners)
        view.addSubview(separatorGenersLabel)
        view.addSubview(descriptionTxtView)
    }
    
    func setupConstraints() {
        //Configurar Constraints
        //Snapkit
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        titulo.snp.makeConstraints { make in
           // make.left.right.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        ButtonFavorite.snp.makeConstraints { make in
            make.top.equalTo(titulo)
            make.right.equalToSuperview().inset(18)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(titulo.snp.bottom).offset(6)
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(7.5)
            make.left.equalToSuperview().offset(20)
            
        }
        
        separatorDateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        
        geners.snp.makeConstraints { make in
            make.top.equalTo(separatorDateLabel.snp.bottom).offset(7.5)
            make.left.equalToSuperview().offset(20)
        }
        
        separatorGenersLabel.snp.makeConstraints { make in
            make.top.equalTo(geners.snp.bottom).offset(6)
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        
        descriptionTxtView.snp.makeConstraints { make in
            make.top.equalTo(separatorGenersLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(25)
            make.height.equalTo(128)
        }
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
    }
    
    @objc func favoriteBtnPressed(_ sender: Any) {
        guard let movie = movieCell else {return}
        let manegerCoreData = ManegerCoreData()
        if (movieCell?.isFavorite != true){
            manegerCoreData.save(bindToMovieEntity(movie), successCompletion: {
                self.ButtonFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
                self.movieCell?.isFavorite = true
                self.EmptyTextField(text: "Adicionado", message: "Este filme foi adicionado aos favoritos!")
            }) { (error) in
                self.ButtonFavorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
                self.EmptyTextField(text: "Errroouuu", message: "Este filme não foi adicionado aos favoritos!")
            }
        }
        else { self.EmptyTextField(text: "Ja adicionado", message: "Este filme já está adicionado aos favoritos!") }
        
    }
    
    private func bindToMovieEntity(_ movie: Result) -> MovieEntity {
        let movie = MovieEntity(context: getCoreDataContext())
        movie.moveId = movieCell?.id ?? 0
        movie.movieDescription = movieCell?.overview
        movie.movieTitle = movieCell?.title
        movie.movieDate = movieCell?.release_date
        movie.movieImage = movieCell?.poster_path
        movie.movieIsFavorite = true
        
        return movie
    }
    
    func getCoreDataContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
