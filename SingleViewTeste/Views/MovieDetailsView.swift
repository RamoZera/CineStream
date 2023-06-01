import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                    } placeholder: {
                        Color.gray
                    }
                } else {
                    Text("No image available")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                    
                    Text("Overview:")
                        .font(.headline)
                        .bold()
                    
                    Text(movie.overview)
                        .font(.body)
                        .lineLimit(nil)
                }
                
                RatingView(rating: movie.voteAverage)
                
                Button{
                    
                } label: {
                    Text ("Buy Ticket")
                }
                .frame(maxWidth: 100, minHeight: 40)
                .background(.blue)
                .tint(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
                .position(x:180, y:35)
            }
            .padding()
        }
        
        
        .navigationBarTitle(Text(movie.title), displayMode: .inline)
    }
}

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack {
            Text("Rating:")
                .font(.headline)
                .bold()
            
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= Int(rating/2) ? "star.fill" : "star")
                    .foregroundColor(index <= Int(rating/2) ? .yellow : .gray)
            }
        }
    }
}
