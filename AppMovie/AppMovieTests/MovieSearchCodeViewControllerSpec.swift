//
//  MovieSearchViewCodeControllerSpec.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 10/09/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import AppMovie


class MovieSearchCodeViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Screen MovieSearchView") {
            it("has valid snapshot") {
                let frame = UIScreen.main.bounds
                let view = MovieSearchView(frame: frame)
                expect(view) == recordSnapshot("MovieSearchCodeViewControllerSpec")
            }
        }
    }
}
