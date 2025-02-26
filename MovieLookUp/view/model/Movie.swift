//
//  Movie.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?
    
    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appendingPathComponent(backdrop_path ?? "")
    }
    
    var posterThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appendingPathComponent(poster_path ?? "")
    }
    
    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appendingPathComponent(poster_path ?? "")
    }
    
    static var preview: Movie {
        return Movie(adult: false,
                     id: 23834,
                     poster_path: "https://image.tmdb.org/t/p/w300",
                     title: "Free Guy",
                     overview: "some demo text here",
                     vote_average: 5.5,
                     backdrop_path: "https://image.tmdb.org/t/p/w300")
    }
}

