//
//  MovieSearchCollectionViewDataSource.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 07/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class MovieSearchCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    let movies:[Result]
    
    init(movies: [Result], collectionView:UICollectionView) {
        self.movies = movies
        super.init()
        registerCells(in: collectionView)
    }
    
    private func registerCells(in collectionView: UICollectionView){
        collectionView.register(cellType: MovieCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    
}
