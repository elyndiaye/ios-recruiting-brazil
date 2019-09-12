//
//  FavoriteMoviesTableViewCell.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable

final class FavoriteMoviesTableCell: UITableViewCell, Reusable {
    
    lazy var imageMovie:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
    
    lazy var titulo: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont(name: "HelveticaNeue", size: 12.0)
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 1
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Title"
        return view
    }()
    
    lazy var descriptionMovie: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont(name: "HelveticaNeue", size: 12.0)
        view.numberOfLines = 15
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.6
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Description"
        return view
    }()
    
    lazy var year: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont(name: "HelveticaNeue", size: 12.0)
        view.adjustsFontSizeToFitWidth = true
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Year"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    //MARK: - ConfigureCell
    func configureCell(movie: MovieEntity) {
        self.titulo.text = movie.movieTitle
        self.year.text = movie.movieDate
        self.descriptionMovie.text = movie.movieDescription
        
        guard let pathImage = (movie.movieImage) else {return}
        let Image = "\(URL_IMG)\(pathImage)"
        imageMovie.download(image: Image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoriteMoviesTableCell: CodeView{
    func buildViewHierarchy() {
        //Adicionar View
        contentView.addSubview(imageMovie)
        contentView.addSubview(titulo)
        contentView.addSubview(year)
        contentView.addSubview(descriptionMovie)
    }
    
    func setupConstraints() {
        //Configurar Constraints
        //Snapkit
        imageMovie.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(31)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(114)
            make.width.equalTo(84)
        }
        
        titulo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8).priority(.high)
            make.left.equalTo(imageMovie.snp.right).offset(16)
            make.height.equalTo(21)
            
        }
        
        year.snp.makeConstraints { make in
            make.top.equalTo(titulo.snp.top)
            make.right.equalToSuperview().inset(8)
        }
        
        descriptionMovie.snp.makeConstraints { make in
            make.top.equalTo(titulo.snp.bottom).offset(3)
            make.right.equalToSuperview().inset(3)
            make.left.equalTo(titulo.snp.left)
            make.bottom.equalToSuperview().inset(10)
            
        }
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
    }
    
}


