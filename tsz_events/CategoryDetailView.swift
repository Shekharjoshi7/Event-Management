//
//  CategoryDetailView.swift
//  hgf
//
//  Created by fcp24 on 10/02/25.
//
import SwiftUI
// MARK: - Category Detail View
struct CategoryDetailView: View {
    let category: ContactCategory

    var body: some View {
      
            List {
                ForEach(category.contacts) { contact in
                    NavigationLink(destination: ContactDetailView(contact: contact)) {
                        ContactRow(contact: contact)
                    }
                }
            }
            .navigationTitle(category.title)
        }
    
}
struct ContactRow: View {
    let contact: Contact

    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.businessName)
                .font(.body)
            Text(contact.phone)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    CategoryDetailView(category:ContactCategory(title: "Anchor", img: "music.microphone", contacts: [
        Contact(name: "David White", phone: "444-555-6666", email: "david@example.com", businessName: "Stage Presence Hosting")
    ]))
}

