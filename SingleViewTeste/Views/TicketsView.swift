//
//  TicketsView.swift
//  SingleViewTeste
//
//  Created by Goncalo Ramos on 07/06/2023.
//

import SwiftUI

struct TicketsView: View {
    @EnvironmentObject private var confirmationDataModel : ConfirmationDataModel
    
    var body: some View {
        if confirmationDataModel.confirmationDataArray.isEmpty{
            Text("No tickets available...")
        } else{
            List(confirmationDataModel.confirmationDataArray, id: \.self) { confirmationData in
                VStack(alignment: .leading) {
                    Text("Movie: \(confirmationData.movieTitle)")
                    Text("Price: \(confirmationData.totalPrice)")
                    Text("Payment Method: \(confirmationData.paymentMethod)")
                }
                Image(systemName: "trash")
            }
        }
    }
}

