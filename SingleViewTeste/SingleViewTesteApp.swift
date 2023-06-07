//
//  SingleViewTesteApp.swift
//  SingleViewTeste
//
//  Created by Goncalo Ramos on 26/05/2023.
//

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
