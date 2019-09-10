//
//  FavoriteMovieViewCodeController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class FavoriteMoviesView: UIView{
    
    lazy var search: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    
    lazy var table: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        return view
    }()
    
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
        addSubview(search)
        addSubview(table)
    }
    
    func setupConstraints() {
        //Configurar Constraints
        //Snapkit
        search.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
        }
        table.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
        
    }
    
}
