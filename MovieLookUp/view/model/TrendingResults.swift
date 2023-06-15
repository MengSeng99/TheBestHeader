//
//  TrendingResults.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import Foundation

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
