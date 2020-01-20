//
//  MovieFavoriteViewCodeControllerSpec.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 05/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import AppMovie


class MovieFavoriteViewCodeControllerSpec: QuickSpec {
    override func spec() {
        describe("Screen FavoriteMovieView") {
            it("has valid snapshot") {
                let frame = UIScreen.main.bounds
                let view = FavoriteMoviesView(frame: frame)
                expect(view) == recordSnapshot("FavoriteMovieViewController")
            }
        }
        
        describe("Favorite Cell") {
            it("Should look like this"){
                let cell = FavoriteMoviesTableCell()
                cell.frame = CGRect(x: 0, y: 0, width: 375, height: 190)
                let view =  cell
                
                expect(view) == recordSnapshot("FavoriteCell")
                
                expect { view.backgroundColor = .red }.to(throwAssertion())
            }
        }
    }
}
