import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    
    
    private enum CodingKeys: String, CodingKey {
        case id, title, posterPath, overview, voteAverage, voteCount
    }
}


struct MovieResponse: Codable {
    let results: [Movie]
}



