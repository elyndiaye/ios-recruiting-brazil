//
//  MovieDetailCodeViewController.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 01/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import AppMovie


class MovieDetailCodeViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Screen DetailView") {
            it("has valid snapshot") {
                let frame = UIScreen.main.bounds
                let view = MovieDetailView(frame: frame)
                expect(view) == recordSnapshot("MovieDetailCodeViewController")
            }
        }
    }
}
