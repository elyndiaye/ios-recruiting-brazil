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

final class : UITableViewCell, NibReusable {
    
    lazy var imageMovie:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
    
    lazy var titulo: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
        view.numberOfLines = 0
        view.adjustsFontSizeToFitWidth = true
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Title"
        return view
    }()
    
    lazy var descriptionMovie: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
        view.adjustsFontSizeToFitWidth = true
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Description"
        return view
    }()
    
    lazy var year: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17)
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
        //        self.titleLbl.text = movie.movieTitle
        //        self.dateLbl.text = movie.movieDate
        //        self.descriptionLbl.text = movie.movieDescription
        //
        //        guard let pathImage = (movie.movieImage) else {return}
        //        let Image = "\(URL_IMG)\(pathImage)"
        //        imageMovie.download(image: Image)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension : CodeView{
    func buildViewHierarchy() {
        //Adicionar View
        contentView.addSubview(imageMovie)
        contentView.addSubview(titulo)
        contentView.addSubview(descriptionMovie)
        contentView.addSubview(year)
    }
    
    func setupConstraints() {
        //Configurar Constraints
        //Snapkit
        imageMovie.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(84)
            make.height.equalTo(114)
        }
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
    }
    
}


