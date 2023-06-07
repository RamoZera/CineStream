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
}
