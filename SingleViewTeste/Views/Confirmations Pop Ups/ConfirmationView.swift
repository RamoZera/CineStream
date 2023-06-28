import SwiftUI
import Foundation

class ConfirmationDataModel: ObservableObject {
    @Published var confirmationDataArray: [ConfirmationData] = []
    
    struct ConfirmationData: Identifiable, Hashable {
        let id = UUID()
        var movieTitle: String = ""
        var session: Date = Date()
        var paymentMethod: String = ""
        var quantity: Int = 0
        var totalPrice: Double = 0.0
    }
    
    func deleteConfirmationData(at index: Int) {
           confirmationDataArray.remove(at: index)
       }
}



struct ConfirmationView: View {
    let movie: Movie
    let buyTicket: () -> Void
    @Binding var isPresented: Bool
    @Binding var session: Date
    @Binding var selectedPaymentMethod: String
    @Binding var quantity: Int
    @Binding var totalPrice: Double
    
    private let paymentMethods = ["Credit Card", "PayPal", "Apple Pay", "MB Way"]
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "info.circle.fill")
                .font(.title)
                .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Filme: \(movie.title)")
                    .font(.headline)
                
                DatePicker(
                    "Sessão:",
                    selection: $session,
                    in: dateRange,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .padding(.leading, -1.0)
                
                Picker(selection: $selectedPaymentMethod, label: Text("Método de Pagamento")) {
                    ForEach(paymentMethods, id: \.self) { method in
                        Text(method)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.leading, -15.0)
                .font(.subheadline)
                
                Text("Preço: 10€")
                    .font(.headline)
                
                HStack {
                    Stepper("Quantidade: \(quantity)", value: $quantity, in: 1...9)
                        .padding(.horizontal)
                    
                    Text("Preço: $\(totalPrice, specifier: "%.2f")")
                        .font(.subheadline)
                }
                .padding(.leading, -15.0)
            }
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button("Confirm") {
                        buyTicket()
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
                
                Spacer()
            }
        }
    }
    
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2023, month: 6, day: 1)
        let endComponents = DateComponents(year: 2023, month: 8, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from: startComponents)! ... calendar.date(from: endComponents)!
    }()
}
