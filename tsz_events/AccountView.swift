//
//  AccountView.swift
//  tsz_events
//
//  Created by fcp24 on 23/01/25.
//

import SwiftUI
import PhotosUI

struct AccountView: View {
    @State private var isNotificationsEnabled: Bool = true
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var selectedImageData: Data?
    @State private var selectedPhoto: PhotosPickerItem?
    
    var initials: String {
        let name = "John Doe"
        let components = name.split(separator: " ")
        return components.map { String($0.prefix(1)) }.joined()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        } else {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 60, height: 60)
                                Text(initials)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("John Doe")
                                .font(.headline)
                            Text("johndoe@example.com")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    PhotosPicker("Change Profile Picture", selection: $selectedPhoto, matching: .images)
                        .onChange(of: selectedPhoto) { newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                }
                
                Section(header: Text("Settings")) {
                    Toggle("Notifications", isOn: $isNotificationsEnabled)
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { newValue in
                            toggleDarkMode(newValue: newValue)
                        }
                }
                
                Section {
                    Button(action: {
                        // Logout action
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Account")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    private func toggleDarkMode(newValue: Bool) {
        print("Dark Mode is now: \(newValue ? "Enabled" : "Disabled")")
    }
}

#Preview {
    AccountView()
}
