//
//  MovieDetailView.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 03/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailView: UIView{
    
    weak var delegate: MovieFavoriteDelegate?
    
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
        return view
    }()
    
    lazy var ButtonFavorite: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        view.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
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
        return view
    }()
    
    lazy var separatorGenersLabel: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var descriptionTxtView: UITextView = {
        let view = UITextView(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.mainDarkBlue()
        view.text = "Description........"
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieDetailView: CodeView{
    func buildViewHierarchy() {
        //Adicionar View
        addSubview(imageView)
        addSubview(titulo)
        addSubview(ButtonFavorite)
        addSubview(separator)
        addSubview(dateLabel)
        addSubview(separatorDateLabel)
        addSubview(geners)
        addSubview(separatorGenersLabel)
        addSubview(descriptionTxtView)
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
            make.top.equalTo(separatorGenersLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(25)
            make.height.equalTo(128)
        }
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
    }
}

//MARK - FavoriteBtnPressed
extension MovieDetailView{
    @objc
    func favoriteBtnPressed() {
        delegate?.pressFavoriteBtn()
    }
    
}
