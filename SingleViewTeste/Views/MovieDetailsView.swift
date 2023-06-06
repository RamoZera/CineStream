import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @State private var showingConfirmation = false
    @State private var movieTitle = ""
    @State private var price = ""
    @State private var paymentMethod = ""
    
    private func buyTicket() {
        movieTitle = movie.title
        price = "$9.99"
        paymentMethod = "Credit Card"
        showingConfirmation = true
    }
    
    var body: some View {
        ScrollView{
        VStack(alignment: .leading, spacing: 16) {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } placeholder: {
                    Color.gray
                        .frame(height: 300)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title)
                    .padding(.vertical)
                
                Text(movie.overview)
                    .font(.body)
                
                Spacer()
                
                RatingView(rating: movie.voteAverage)
            }
            
            
            Button("Buy Ticket") {
                buyTicket()
            }
            .padding()
            .sheet(isPresented: $showingConfirmation) {
                ConfirmationView(movie: movie, isPresented: $showingConfirmation)
            }
            .frame(maxWidth: 130, minHeight: 40)
            .background(.blue)
            .tint(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
            .position(x:180, y:35)
        }
        .padding()
        .navigationBarTitle(movie.title)
    }
    }
    
    struct ConfirmationView: View {
        let movie: Movie
        @Binding var isPresented: Bool
        
        var body: some View {
               VStack(spacing: 16) {
                   Text("Confirm Purchase")
                       .font(.title)
                       .padding()
                   
                   VStack(alignment: .leading, spacing: 8) {
                       Text("Movie: \(movie.title)")
                           .font(.headline)
                       
                       Text("Price: $10")
                           .font(.subheadline)
                       
                       Text("Payment Method: Credit Card")
                           .font(.subheadline)
                   }
                   .padding(.horizontal)
                   
                   Spacer()
                   
                   Button("Confirm") {
                       isPresented = false
                   }
                   .font(.headline)
                   .foregroundColor(.white)
                   .padding()
                   .background(Color.blue)
                   .cornerRadius(10)
                   
                   Button("Cancel") {
                       isPresented = false
                   }
                   .font(.headline)
                   .foregroundColor(.blue)
               } 
           }
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

