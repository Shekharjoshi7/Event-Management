//
//  CreateEventForm.swift
//  hgf
//
//  Created by fcp24 on 10/02/25.
//

import SwiftUI
// MARK: - Create Event Form
struct CreateEventForm: View {
    @Binding var upcomingEvents: [Event]
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var description = ""
    @State private var imageName = ""
    @State private var date = ""
    @State private var location = ""
    @State private var category = ""

    let categories: [String] = ["Music", "Sports", "Workshops", "Tech Talks", "Others"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Name")) {
                    TextField("Enter event name", text: $name)
                        .autocapitalization(.none) // Allows both uppercase & lowercase
                }

                Section(header: Text("Description")) {
                    TextField("Enter event description", text: $description)
                        .autocapitalization(.none)
                }

                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Section(header: Text("Image Name")) {
                    TextField("Enter image file name (e.g., event1)", text: $imageName)
                        .autocapitalization(.none)
                }

                Section(header: Text("Event Date")) {
                    TextField("Enter date", text: $date)
                        .autocapitalization(.none)
                }
                Section(header: Text("Event Location")) {
                    TextField("Enter location", text: $location)
                        .autocapitalization(.none)
                }

                Button(action: {
                    // Format the input correctly before adding
                    let formattedEvent = Event(
                        id:"1",
                        name: name.capitalized, // Ensures first letter uppercase
                        description: description.capitalized,
                        images: [imageName],
                        date: date,
                        location: location,
                        category: category
                    )

                    upcomingEvents.append(formattedEvent)
                    dismiss()
                }) {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Create Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
