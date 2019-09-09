//
//  FavoriteMovieViewCodeController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class FavoriteMoviesView: UIView{
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoriteMoviesView: CodeView{
    func buildViewHierarchy() {
        //Adicionar View
    }
    
    func setupConstraints() {
        //Configurar Constraints
        //Snapkit
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
        backgroundColor = .white
        separatorStyle = .none
    }
    
}
