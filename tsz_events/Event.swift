import SwiftUI
import FirebaseDatabase

struct Event: Identifiable, Codable {
    var id: String  // Ensure id is a String (matching Firebase keys)
    var name: String
    var description: String
    var images: [String]
    var date: String
    var location: String
    var category: String
}

struct EventGalleryView: View {
    @State private var isConnected = false
    @State private var events: [Event] = []  // Array to hold fetched events

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(events) { event in
                        NavigationLink(destination: EventFolderView(event: event)) {
                            ZStack {
                                if let firstImage = event.images.first {
                                    Image(firstImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .opacity(0.7)
                                } else {
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .opacity(0.7)
                                }

                                Text(event.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.top, 80)
                            }
                            .frame(width: 180, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 2)
                        }
                    }
                }
                .padding()

                VStack {
                    Text(isConnected ? "Connected to Firebase" : "Not Connected")
                        .foregroundColor(isConnected ? .green : .red)
                        .bold()
                }
                .padding()
            }
            .navigationTitle("Event Gallery")
            .onAppear {
                checkFirebaseConnection()
                fetchEventsFromFirebase()
            }
        }
    }

    // ✅ Function to Check Firebase Connection
    func checkFirebaseConnection() {
        let ref = Database.database().reference(withPath: ".info/connected")
        ref.observe(.value) { snapshot in
            if let connected = snapshot.value as? Bool {
                isConnected = connected
            }
        }
    }

    // ✅ Function to Fetch Events from Firebase
    func fetchEventsFromFirebase() {
        let ref = Database.database().reference(withPath: "event/events") // ✅ Correct path

        ref.observe(.value) { snapshot in
            var loadedEvents: [Event] = []

            guard snapshot.exists() else {
                print("No events found in Firebase")
                return
            }

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let eventDict = snapshot.value as? [String: Any] {
                    
                    let id = snapshot.key  // Firebase's unique key as event ID
                    let name = eventDict["name"] as? String ?? "Unknown Event"
                    let description = eventDict["description"] as? String ?? "No description available."
                    let images = eventDict["images"] as? [String] ?? []
                    let date = eventDict["date"] as? String ?? "Unknown Date"
                    let location = eventDict["location"] as? String ?? "Unknown Location"
                    let category = eventDict["category"] as? String ?? "Uncategorized"

                    let event = Event(id: id, name: name, description: description, images: images, date: date, location: location, category: category)
                    print(event)
                    loadedEvents.append(event)
                }
            }

            self.events = loadedEvents
        }
    }

}

// ✅ View to Display Event Details & Images
struct EventFolderView: View {
    var event: Event
    @State private var selectedImage: String? = nil

    var body: some View {
        VStack {
            Text(event.name)
                .font(.title)
                .bold()
                .padding()

            if !event.images.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(event.images, id: \.self) { image in
                            Button(action: {
                                selectedImage = image
                            }) {
                                Image(image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 150)
                                    .clipped()
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                Text("No images available")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle(event.name)
        .navigationBarTitleDisplayMode(.inline)
//        .fullScreenCover(item: $selectedImage) { selectedImage in
//            FullScreenImageView(imageName: selectedImage.imageName, selectedImage: $selectedImage)
//        }
    }
}
struct IdentifiableImage: Identifiable {
    var id = UUID()
    var imageName: String
}


struct FullScreenImageView: View {
    var imageName: String
    @Binding var selectedImage: IdentifiableImage?

    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .padding()
            Spacer()
            Button(action: {
                withAnimation {
                    selectedImage = nil
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                  
            }
        }
        .background(Color.black.opacity(1.8))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    EventGalleryView()
}
