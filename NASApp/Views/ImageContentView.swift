//
//  ImageContentView.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import SwiftUI

struct ImageContentView: View {
    
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                ContentUnavailableView(
                    "Failed to Load Image",
                    systemImage: "photo.badge.exclamationmark",
                    description: Text("The image could not be loaded")
                )
                .frame(height: 200)
            @unknown default:
                EmptyView()
            }
        }
    }
}

