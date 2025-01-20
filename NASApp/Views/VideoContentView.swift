//
//  VideoContentView.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import SwiftUI
import AVKit

struct VideoContentView: View {
    let url: URL
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: url))
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color(.systemBackground))
    }
}
