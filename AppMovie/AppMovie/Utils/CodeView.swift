//
//  CodeView.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 31/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView{
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

//Para garantir que os metodos vao ser executados na ORDEM correta
extension CodeView{
    func setupView(){
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
