//
//  MovieSearchView.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 10/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

final class MovieSearchView: UIView{
    
    lazy var search: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    
    lazy var collection: UICollectionView = {
         let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .white
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

extension MovieSearchView: CodeView{
    func buildViewHierarchy() {
        //Adicionar View
        addSubview(search)
        addSubview(collection)
    }
    
    func setupConstraints() {
        //Configurar Constraints
        //Snapkit
        search.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
        }
        
        collection.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        //Setup adicional
    }
    
}
