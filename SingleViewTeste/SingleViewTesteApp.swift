import SwiftUI
@main
struct SingleViewTesteApp: App {
    @StateObject private var  confirmationDataModel = ConfirmationDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(confirmationDataModel)
        }
    }
}
