//
//  ContentView.swift
//  NASApp
//
//  Created by Patrick Perdon on 18/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let apod = try await APODManager.shared.getApod()
                print(apod)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
