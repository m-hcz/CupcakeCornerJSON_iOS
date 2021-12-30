//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by M H on 30/12/2021.
//

import SwiftUI






struct ContentView: View {
	
	@StateObject var order = Order()

	
	
    var body: some View {
		VStack {
			
			AsyncImage(url: URL(string: "https:/hws.dev/img/logo.png")) {phase in
				if let image = phase.image {
					image
						.resizable()
						.scaledToFit()
				} else if phase.error != nil {
					Image(systemName: "exclamationmark.icloud")
						.font(.system(size: 50))
						.foregroundColor(.gray)
				}
				else {
					ProgressView()
				}
			}
			.frame(width: 200, height: 200)
			
			
			NavigationView {
				Form{
					Section {
						Picker("Select your cake type", selection: $order.type) {
							ForEach(Order.types.indices) {
								Text(Order.types[$0])
							} // for
						} // picker
						
						Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
					} // sec
					Section {
						Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
						
						if order.specialRequestEnabled {
							Toggle("Add extra frosting", isOn: $order.extraFrosting)
							Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
						} // if
					} // sec
				
					Section {
						NavigationLink {
							AddressView(order: order)
						} label: {
							Text("Delivery details")
						} // navl
					} // form
					
				} // form
				.navigationTitle("Capcake Corner")
			} // navv
			
			
			
		} // vs
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
