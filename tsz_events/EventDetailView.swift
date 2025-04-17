//
//  EventDetailView.swift
//  hgf
//
//  Created by fcp24 on 10/02/25.
//


import SwiftUI

struct EventDetailView: View {
    var event: Event
    
    var body: some View {
        VStack {
            Image(event.images.first ?? "placeholder")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .clipped()
            
            Text(event.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(event.description)
                .font(.body)
                .padding()
            
            Text(event.date)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            Text(event.location)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                // Handle event registration
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .navigationBarTitle(event.name, displayMode: .inline)
    }
}

#Preview {
    EventDetailView(event:Event(id:"1",name: "Manoranjan", description: "Join us for a night of live music and fun.", images: ["t1"], date: "25/01/2025", location: "Vigyan Bhawan Block-A", category: "Music"))
}
