//
//  tsz_eventsApp.swift
//  tsz_events
//
//  Created by fcp24 on 23/01/25.
//

import SwiftUI
import FirebaseCore


@main
struct tsz_eventsApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
            
        }
    }
}
