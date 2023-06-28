import SwiftUI

struct MovieListView: View {
    @State private var movies: [Movie] = []
    @State private var searchQuery: String = ""
    @State private var filteredMovies: [Movie] = []
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: filterMovies) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredMovies) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieListItemView(movie: movie)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchData()
        }
        .onChange(of: searchQuery) { _ in
            filterMovies()
        }
    }
    
    private func fetchData() {
        MoviesListViewModel.fetchMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.filteredMovies = movies
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func filterMovies() {
        if searchQuery.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}


struct MovieListItemView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

