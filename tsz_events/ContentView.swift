//
//  ContentView.swift
//  tsz_events
//
//  Created by fcp24 on 23/01/25.
//

import SwiftUI

// Main ContentView with TabView
struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ContactView()
                .tabItem {
                    Label("Contact", systemImage: "person.3")
                }
            
            EventGalleryView()
                .tabItem {
                    Label("Gallery", systemImage: "photo")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "gearshape")
                }
        }
    }
}

// Preview
#Preview {
    ContentView()
}
