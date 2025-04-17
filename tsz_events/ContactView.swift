import SwiftUI

// MARK: - Contact Models
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let email: String
    let businessName: String
}

struct ContactCategory: Identifiable {
    let id = UUID()
    let title: String
    let img: String
    let contacts: [Contact]
}
struct Service: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}
// MARK: - Main Contact View
struct ContactView: View {
    let contactCategories: [ContactCategory] = [
        ContactCategory(title: "DJ", img: "music.note", contacts: [
            Contact(name: "John Doe", phone: "123-456-7890", email: "johndoe@example.com", businessName: "Epic Beats Entertainment"),
            Contact(name: "Alice Smith", phone: "987-654-3210", email: "alice@example.com", businessName: "Rhythm Masters")
        ]),
        ContactCategory(title: "Decoration", img: "party.popper.fill", contacts: [
            Contact(name: "Bob Johnson", phone: "555-123-4567", email: "bob@example.com", businessName: "Elegant Event Designs")
        ]),
        ContactCategory(title: "Catering", img: "fork.knife", contacts: [
            Contact(name: "Charlie Brown", phone: "111-222-3333", email: "charlie@example.com", businessName: "Gourmet Delights Catering")
        ]),
        ContactCategory(title: "Anchor", img: "music.microphone", contacts: [
            Contact(name: "David White", phone: "444-555-6666", email: "david@example.com", businessName: "Stage Presence Hosting")
        ]),
        ContactCategory(title: "Team", img: "person.3", contacts: [
            Contact(name: "Eve Black", phone: "777-888-9999", email: "eve@example.com", businessName: "Prime Event Management")
        ])
    ]

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(contactCategories) { category in
                        // All categories open in a new page
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCardView(category: category)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Business Categories")
        }
    }
}


// MARK: - Contact Row View


// MARK: - Category Card View (Reusable)
struct CategoryCardView: View {
    let category: ContactCategory

    var body: some View {
        VStack {
            Image(systemName: category.img)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)

            Text(category.title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 160, height: 160)
        .background(Color.black.opacity(0.8))
        .cornerRadius(100)
        .shadow(radius: 3)
    }
}



// MARK: - Preview
#Preview {
    ContactView()
}
