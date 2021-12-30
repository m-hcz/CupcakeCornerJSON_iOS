//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by M H on 30/12/2021.
//

import SwiftUI

struct CheckoutView: View {
	
	// MARK: props
	@ObservedObject var order: Order
	@State private var confirmationMessage = ""
	@State private var showConfirmation = false
	
	// MARK: func
	func placeOrder() async {
		guard let encoded = try? JSONEncoder().encode(order) else {
			print("Failed to encode order")
			return
		}
		
		let url = URL(string: "https://reqres.in/api/cupcakesswiftui")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		
		do {
			let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
			
			let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
			confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
			showConfirmation = true
		} catch {
			print("Checkout failed")
		}
	} // f
	
	// MARK: body
    var body: some View {
		ScrollView {
			VStack {
				AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { phase in
					if let image = phase.image {
						image
							.resizable()
							.scaledToFit()
					} else if phase.error != nil {
						Image(systemName: "cake")
					} else {
						ProgressView()
					}
				} // img
				.frame(height: 233)
				
				Text("Your total is \(order.cost, format: .currency(code: "USD"))")
					.font(.title)
				
				Button("Place Order", action: {
					Task{
						await placeOrder()
					}
				}) // butt
					.padding()
			} // v
		} // scrlv
		.navigationTitle("Check out")
		.navigationBarTitleDisplayMode(.inline)
		.alert("Thank you!", isPresented: $showConfirmation) {
			Button("OK") { }
		} message: {
			Text(confirmationMessage)
		} // alert
		
	}
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
