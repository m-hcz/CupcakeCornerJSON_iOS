//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by M H on 30/12/2021.
//

import SwiftUI

struct AddressView: View {
	
	@ObservedObject var order: Order
	
    var body: some View {
		Form {
			Section {
				TextField("Name", text: $order.name)
				TextField("Street address", text: $order.streetAddress)
				TextField("City", text: $order.city)
				TextField("Zip", text: $order.zip)
			}
			
			Section {
				NavigationLink {
					CheckoutView(order: order)
				} label: {
					Text("Check out")
				} // navl
			} // sec
			.disabled(!order.hasValidAddress)
		} // f
		.navigationTitle("Delivery details")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
