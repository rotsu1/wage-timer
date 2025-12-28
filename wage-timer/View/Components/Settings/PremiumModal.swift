//
//  PremuimModal.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 28/12/2025.
//
import SwiftUI

struct PremiumModal: View {
    var body: some View {
        VStack {    
            HStack {
                Text(" ")
                Spacer()
                Text("Premium")
                Spacer()
                Text(" ")
            }
            .padding()              
            VStack {
                Image(systemName: "trophy.fill")
                    .resizable()
                    .foregroundStyle(Color.rgbo(red: 235, green: 235, blue: 48, opacity: 1))
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 16)
                Text("We will add more features in the future")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.bottom, 8)
            }
            
            Spacer()
        }
        .foregroundStyle(.black)
        .padding()
    }
}
