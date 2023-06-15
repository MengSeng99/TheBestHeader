//
//  MovieDiscoverViewModel.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import Foundation

@MainActor
class MovieDiscoverViewModel: ObservableObject {

    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []

    static let apiKey = "ab8ca7862f2733af2356c592de5f9d45"

    //https://api.themoviedb.org/3/movie/550?api_key=ab8ca7862f2733af2356c592de5f9d45

    //https://api.themoviedb.org/3/trending/movie/day?api_key=ab8ca7862f2733af2356c592de5f9d45

    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDiscoverViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US&page=1&include_adult=false&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

