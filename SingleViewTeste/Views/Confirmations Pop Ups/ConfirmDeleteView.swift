import SwiftUI

struct ConfirmationPopupView: View {
    let deleteAction: () -> Void
    let cancelAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.title)
                .padding()
            
            Divider()
            
            Text("Are you sure you want to delete this ticket?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Divider()
            
            HStack(spacing: 16) {
                Button(action: deleteAction) {
                    Text("Delete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Button(action: cancelAction) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }

}
