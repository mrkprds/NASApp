//
//  APODView.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import SwiftUI

struct APODView: View {
    
    @State private var viewModel = APODViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                idleView
            case .loading:
                loadingView
            case .success(let apod):
                ScrollView {
                    mediaContent(for: apod.mediaType, with: apod.url)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.displayTitle)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(viewModel.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text(viewModel.textBody)
                            .font(.body)
                    }
                    .padding(.horizontal)
                }
                
            case .failure(let error):
                failureView(with: error)
            }
        }
        .task {
            await viewModel.fetchAPOD()
        }
    }
    
    @ViewBuilder
    private func mediaContent(
        for mediaType: APOD.MediaType,
        with url: URL
    ) -> some View {
        switch mediaType {
        case .image:
            ImageContentView(url: url)
        case .video:
            VideoContentView(url: url)
        default:
            ContentUnavailableView(
                "Unsupported Media Type",
                systemImage: "questionmark.circle",
                description: Text("This type of media cannot be displayed")
            )
        }
    }
    
    @ViewBuilder
    var idleView: some View {
        ContentUnavailableView(
            "Astronomy Picture of the Day",
            systemImage: "star.circle.fill",
            description: Text("Tap to discover today's cosmic view")
        )
        .onTapGesture {
            Task {
                await viewModel.fetchAPOD()
            }
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        ContentUnavailableView {
            ProgressView()
        } description: {
            Text("Fetching today's astronomy picture...")
        }
    }
    
    @ViewBuilder
    func failureView(with error: Error) -> some View {
        ContentUnavailableView {
            Label("Error", systemImage: "exclamationmark.triangle")
        } description: {
            Text(error.localizedDescription)
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.fetchAPOD()
                }
            }
            .buttonStyle(.bordered)
        }
    }
}


#Preview {
    APODView()
}
