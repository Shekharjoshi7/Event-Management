import SwiftUI

struct HomeView: View {
    @State private var upcomingEvents: [Event] = [
        Event(id:"1",name: "Manoranjan", description: "Join us for a night of live music and fun.", images: ["t1"], date: "25/01/2025", location: "Vigyan Bhawan Block-A", category: "Music"),
        Event(id:"1",name: "Tech Jalsa", description: "A tech conference featuring industry leaders.", images: ["t2"], date: "15/02/2025", location: "Tech Park", category: "Tech Talks"),
        Event(id:"1",name: "Sports Meet", description: "Get ready for a day full of sports and competitions.", images: ["t3"], date: "05/03/2025", location: "Sports Ground", category: "Sports"),
        Event(id:"1",name: "Cultural Fest", description: "Experience diverse cultural performances.", images: ["15"], date: "25/03/2025", location: "Vivekanand Auditorium", category: "Others"),
        Event(id:"1",name: "Party", description: "A night of music and dance.", images: ["m11"], date: "15/03/2025", location: "Ballroom", category: "Music")
    ]

    let categories: [String] = ["Music", "Sports", "Workshops", "Tech Talks", "Others"]

    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    @State private var isSlidingForward = true
    @State private var isShowingCreateEventForm = false

    let columns = [GridItem(.flexible()), GridItem(.flexible())]  // 2 columns

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 5) {
                    // Home Title
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    // Sliding Events Section
                    TabView(selection: $currentIndex) {
                        ForEach(upcomingEvents.indices, id: \.self) { index in
                            NavigationLink(destination: EventDetailView(event: upcomingEvents[index])) {
                                ZStack {
                                    Image(upcomingEvents[index].images.first ?? "placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 250)
                                        .clipped()
                                        .cornerRadius(12)

                                    VStack {
                                        Spacer()
                                        Text(upcomingEvents[index].name)
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxHeight: .infinity, alignment: .top)
                                }
                                .tag(index)
                            }
                        }
                    }
                    .frame(height: 250)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    HStack(spacing: 10) {
                        ForEach(upcomingEvents.indices, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.gray.opacity(1.5) : Color.gray.opacity(0.6))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 10)

                    // Categories Section
                    Text("Categories")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { category in
                                NavigationLink(destination: CategoryEventsView(category: category, events: upcomingEvents)) {
                                    ZStack(alignment: .bottomLeading) {
                                        Image(category)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 200)
                                            .clipped()
                                            .cornerRadius(12)

                                        Text(category)
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding()
                                            .shadow(radius: 5)
                                    }
                                    .frame(width: 140, height: 200)
                                    .shadow(radius: 5)
                                }
                            }
                        }
                        .padding(.all, 10)
                    }

                    // Create Event Button
                    Button(action: {
                        isShowingCreateEventForm = true
                    }) {
                        Text("Create Event")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.top, 9)

                    // Upcoming Events Section in 2x2 Grid
                    Text("Upcoming Events")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)

                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(upcomingEvents.filter { isFutureEvent($0.date) }, id: \.name) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
                                VStack {
                                    Image(event.images.first ?? "placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 120)
                                        .clipped()
                                        .cornerRadius(8)

                                    VStack {
                                        Text(event.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.center)

                                        Text(event.date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.top, 5)
                                }
                                .frame(width: 160)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
            .onAppear {
                startAutomaticSlideshow()
            }
            .onDisappear {
                timer?.invalidate()
            }
            .sheet(isPresented: $isShowingCreateEventForm) {
                CreateEventForm(upcomingEvents: $upcomingEvents)
            }
        }
    }

    // Function to check if the event is in the future
    func isFutureEvent(_ eventDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current

        if let eventDate = dateFormatter.date(from: eventDate) {
            return eventDate >= Date()
        }
        return false
    }

    func startAutomaticSlideshow() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.2, repeats: true) { _ in
            withAnimation {
                if isSlidingForward {
                    currentIndex = (currentIndex + 1) % upcomingEvents.count
                    if currentIndex == upcomingEvents.count - 1 {
                        isSlidingForward.toggle()
                    }
                } else {
                    currentIndex = (currentIndex - 1 + upcomingEvents.count) % upcomingEvents.count
                    if currentIndex == 0 {
                        isSlidingForward.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
