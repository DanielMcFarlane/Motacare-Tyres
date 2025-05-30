//
//  OrderDetailsCard.swift
//  Motacare Tyres
//
//  Created by Daniel McFarlane on 25/04/2025.
//
//  This view displays a card with order details for the order confirmation view.
//

import SwiftUI

struct OrderDetailsCard: View {
    var basketItems: [BasketItem]
    var bookingDate: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Tyre Details
            
            ForEach(basketItems, id: \.id) { basketItem in
                HStack(alignment: .center, spacing: 16) {
                    // Tyre image
                    Image("Tyre-Stock-Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 140)
                        .cornerRadius(12)
                        .shadow(radius: 4)

                    VStack(alignment: .leading, spacing: 8) {
                        // Tyre name
                        Text("\(basketItem.tyre.brand) \(basketItem.tyre.model)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .lineLimit(nil)

                        // Tyre specifications
                        Text("\(basketItem.tyre.width)/\(basketItem.tyre.profile)/\(basketItem.tyre.rimSize) \(basketItem.tyre.speedRating)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        HStack {
                            // Price
                            Text("£\(String(format: "%.2f", basketItem.tyre.price))")
                                .font(.title3)
                                .fontWeight(.bold)

                            // Quantity
                            Text("x \(basketItem.quantity)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        if basketItem.tyre.isWinter {
                            // Winter tag
                            Label("Winter Tyre", systemImage: "snowflake")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.15))
                                .foregroundColor(.blue)
                                .cornerRadius(6)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Divider().padding(.horizontal, 64)

            // MARK: - Total
            
            HStack {
                // Total
                Text("Total:")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Total price
                Text("£\(String(format: "%.2f", basketItems.reduce(0) { $0 + $1.tyre.price * Double($1.quantity) }))")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    let sampleTyre = Tyre(
        width: "205",
        profile: "55",
        rimSize: "16",
        brand: "Continental",
        model: "ContiPremiumContact 6",
        speedRating: "V",
        price: 89.99,
        isWinter: false,
        category: "Premium"
    )

    let sampleBasketItem = BasketItem(tyre: sampleTyre, quantity: 2)

    OrderDetailsCard(
        basketItems: [sampleBasketItem],
        bookingDate: Date()
    )
    .padding()
}
