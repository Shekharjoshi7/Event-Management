//
//  CategoryEventsView.swift
//  hgf
//
//  Created by fcp24 on 10/02/25.
//

import SwiftUI
struct CategoryEventsView: View {
    let category: String
    let events: [Event]

    var filteredEvents: [Event] {
        events.filter { $0.category == category }
    }

    var body: some View {
        VStack {
            Text("\(category) Events")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            if filteredEvents.isEmpty {
                Text("No events found in this category.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredEvents, id: \.name) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
                                ZStack {
                                    Image(event.images.first ?? "placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipped()
                                        .cornerRadius(12)

                                    VStack {
                                        Spacer()
                                        Text(event.name)
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(.white)
                                            .shadow(radius: 5)
                                    }
                                    .padding()
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle(category)
    }
}
#Preview {
    CategoryEventsView(category: "Music", events: [
        Event(id:"1",name: "Manoranjan", description: "Join us for a night of live music and fun.", images: ["t1"], date: "25/01/2025", location: "Vigyan Bhawan Block-A", category: "Music"),
        Event(id:"1",name: "Tech Jalsa", description: "A tech conference featuring industry leaders.", images: ["t2"], date: "15/02/2025", location: "Tech Park", category: "Tech Talks"),
        Event(id:"1",name: "Sports Meet", description: "Get ready for a day full of sports and competitions.", images: ["t3"], date: "05/03/2025", location: "Sports Ground", category: "Sports"),
        Event(id:"1",name: "Cultural Fest", description: "Get ready for a day full of illusional culture.", images: ["15"], date: "25/03/2025", location: "Vivekanand Auditorium", category: "Others"),
        Event(id:"1",name: "PARTY", description: "Get ready for a day full of illuring western culture", images: ["m11"], date: "15/03/2025", location: "Ballroom", category: "Music")
    ])
}
