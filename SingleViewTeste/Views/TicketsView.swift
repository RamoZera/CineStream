import SwiftUI



    struct TicketsView: View {
        @EnvironmentObject private var confirmationDataModel: ConfirmationDataModel
        
        var body: some View {
            if confirmationDataModel.confirmationDataArray.isEmpty {
                Text("No tickets available...")
                    .foregroundColor(.secondary)
            } else {
                List(confirmationDataModel.confirmationDataArray) { confirmationData in
                    TicketRowView(confirmationData: confirmationData)
                }
            }
        }
    }
    
    struct TicketRowView: View {
        @EnvironmentObject private var confirmationDataModel: ConfirmationDataModel
        let confirmationData: ConfirmationDataModel.ConfirmationData
        @State private var showConfirmationPopup = false
        @State private var selectedIndex: Int? = nil
        
        var body: some View {
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(confirmationData.movieTitle)
                            .font(.headline)
                        Text("Payment Method: \(confirmationData.paymentMethod)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("€\(confirmationData.totalPrice, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("Quantity: \(confirmationData.quantity)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                        .background(Color.gray)
                        .frame(height: 30)
                    
                    Button(action: {
                        selectedIndex = confirmationDataModel.confirmationDataArray.firstIndex(where: { $0 == confirmationData })
                        showConfirmationPopup = true
                    }) {
                        Image(systemName: "trash")
                    }
                    .foregroundColor(.black)
                    .sheet(isPresented: $showConfirmationPopup) {
                        ConfirmationPopupView(deleteAction: {
                            if let index = selectedIndex {
                                confirmationDataModel.deleteConfirmationData(at: index)
                            }
                            showConfirmationPopup = false
                        }, cancelAction: {
                            showConfirmationPopup = false
                        })
                    }
                }
                
            }
        }
    }



