import Foundation

class MoviesListViewModel {
    var movies: [Movie] = []
    
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




