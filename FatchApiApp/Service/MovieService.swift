//
//  MovieService.swift
//  FatchApiApp
//
//  Created by Hendaru on 19/12/23.
//

import Foundation

class MoviesService {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func getMoviesFromApi() async throws -> [Movie] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try jsonDecoder.decode(MoviesResponse.self, from: data)

        return decoded.results
    }
}
