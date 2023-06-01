//
//  MoviesManager.swift
//  SingleViewTeste
//
//  Created by Goncalo Ramos on 29/05/2023.
//

import Foundation

class MoviesManager {
    static func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=d2ea758c1787f6f8715df6713125a180") else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(movieResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    
    // Add other properties you need
    
    private enum CodingKeys: String, CodingKey {
        case id, title, posterPath, overview, voteAverage, voteCount
    }
}


struct MovieResponse: Codable {
    let results: [Movie]
}

