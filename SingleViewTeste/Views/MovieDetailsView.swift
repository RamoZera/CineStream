import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject private var confirmationDataModel: ConfirmationDataModel
    
    let movie: Movie
    @State private var showingConfirmation = false
    @State private var session = Date()
    @State private var selectedPaymentMethod = "Credit Card"
    @State private var quantity = 1
    @State private var totalPrice = 10.0
    
    private func buyTicket() {
        let confirmationData = ConfirmationDataModel.ConfirmationData(
            movieTitle: movie.title,
            session: session,
            paymentMethod: selectedPaymentMethod,
            quantity: quantity,
            totalPrice: totalPrice
        )
        confirmationDataModel.confirmationDataArray.append(confirmationData)
        print(confirmationData)
    }
    
   private func showPopUp() {
        showingConfirmation = true
    }
    
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
                    showPopUp()
                }
                .padding()
                .frame(maxWidth: 130, minHeight: 40)
                .background(.blue)
                .tint(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
                .position(x: 180, y: 35)
            }
            .padding()
            .navigationBarTitle(movie.title)
        }
        .overlay {
            ConfirmationView(
                movie: movie,
                buyTicket: buyTicket,
                isPresented: $showingConfirmation,
                session: $session,
                selectedPaymentMethod: $selectedPaymentMethod,
                quantity: $quantity,
                totalPrice: $totalPrice
            )
            .frame(width: 380, height: 800)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .padding()
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 150)
            .opacity(showingConfirmation ? 1 : 0)
            .animation(.easeInOut)
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
