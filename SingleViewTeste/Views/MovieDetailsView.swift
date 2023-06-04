import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @State private var showingConfirmation = false
    @State private var movieTitle = ""
    @State private var price = ""
    @State private var paymentMethod = ""
    
    private func buyTicket() {
        movieTitle = movie.title
        price = "$9.99" // Replace with actual price
        paymentMethod = "Credit Card" // Replace with actual payment method
        showingConfirmation = true
    }
    
    var body: some View {
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
                ConfirmationView(
                    movieTitle: movieTitle,
                    price: price,
                    paymentMethod: paymentMethod,
                    isPresented: $showingConfirmation
                )
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
    
    struct ConfirmationView: View {
        let movieTitle: String
        let price: String
        let paymentMethod: String
        @Binding var isPresented: Bool
        
        var body: some View {
            VStack {
                Text("Confirm Purchase")
                    .font(.title)
                    .padding()
                
                Text("Movie: \(movieTitle)")
                    .font(.headline)
                    .padding(.bottom)
                
                Text("Price: \(price)")
                    .font(.subheadline)
                    .padding(.bottom)
                
                Text("Payment Method: \(paymentMethod)")
                    .font(.subheadline)
                
                Spacer()
                
                Button("Confirm") {
                    // Perform the purchase action here
                    
                    // Dismiss the confirmation popup
                    isPresented = false
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.bottom)
                
                Button("Cancel") {
                    // Dismiss the confirmation popup
                    isPresented = false
                }
                .font(.headline)
                .foregroundColor(.blue)
            }
            .padding()
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

