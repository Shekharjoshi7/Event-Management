//
//  ContactDetailView.swift
//  hgf
//
//  Created by fcp24 on 10/02/25.
//

import SwiftUI

// MARK: - Contact Detail View
struct ServiceCardView: View {
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(service.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(12)
            
            Text(service.title)
                .font(.headline)
                
            
            Text(service.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
            
        }
        .padding()
        .cornerRadius(12)
        .shadow(radius: 5)
       
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct ContactDetailView: View {
    let contact: Contact
    let services: [Service] = [
        Service(title: "Custom Software Development",
                description: "We design and develop bespoke software applications that align with your business goals and processes.",
                imageName: "m1"),
        
        Service(title: "Web Development",
                description: "Our team builds dynamic, responsive websites and web applications using the latest technologies.",
                imageName: "m2"),
        
        Service(title: "Enterprise Solutions",
                description: "From CRM systems to ERP solutions, we develop scalable software that streamlines your enterprise operations.",
                imageName: "m3")
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack(alignment: .bottom) {
                        Image("m1")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .cornerRadius(12)
                        
                        VStack(alignment: .center) {
                            Image("contact image")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                                .cornerRadius(100)
                        }
                        .offset(y: 40)
                    }
                    
                    Text(contact.name)
                        .font(.title)
                        .bold()
                        .offset(y: 20)
                    
                    VStack {
                        Text("With years of experience and a deep passion for music, DJ Vala is more than just a performer—Vala is an experience. From smooth transitions to hard-hitting drops, every set is a story, and every beat is designed to make the crowd move. Book DJ Vala for your next event and let the music speak for itself!")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)

                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.green)
                            Text(contact.phone)
                        }
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                            Text(contact.email)
                        }
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.green)
                            Text("JOHNDOE123")
                        }
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                            Text("UDAIPUR")
                        }
                    }
                    .offset(x: -75)

                    Spacer()

                    Text("Our Services")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    ForEach(services) { service in
                        ServiceCardView(service: service)
                    }
                }
                .padding()
                .navigationTitle(contact.businessName)
            }
            
            // Floating WhatsApp Button
            Button(action: {
                let phoneNumber = contact.phone.replacingOccurrences(of: " ", with: "") // Ensure no spaces in number
                let whatsappURL = "https://wa.me/\(phoneNumber)"
                if let url = URL(string: whatsappURL) {
                    UIApplication.shared.open(url)
                }
            }) {
                Image("whatsapp") // Use a WhatsApp icon image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .shadow(radius: 5)
            }
            .padding(10)
        }
    }
} 

#Preview {
    ContactDetailView(contact:
        Contact(name: "David White", phone: "444-555-6666", email: "david@example.com", businessName: "Stage Presence Hosting")
    )
}

