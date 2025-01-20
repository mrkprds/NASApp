//
//  APODViewModel.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

@Observable
class APODViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case success(APOD)
        case failure(Error)
    }
    
    var state: State = .idle
    
    var mediaType: APOD.MediaType? {
        guard case .success(let apod) = state else {
            return nil
        }
        
        return apod.mediaType
    }
    
    var displayTitle: String {
        switch state {
        case .idle:
            return "Astronomy Picture of the Day"
        case .loading:
            return "Loading..."
        case .success(let apod):
            return apod.title
        case .failure:
            return "Error"
        }
    }
    
    var subtitle: String {
        switch state {
        case .idle:
            return "Tap to discover today's cosmic view"
        case .loading:
            return "Loading..."
        case .success(let apod):
            return dateToString(from: apod.date)
        case .failure:
            return "Error"
        }
    }
    
    var textBody: String {
        guard case .success(let apod) = state else {
            return ""
        }
        
        return apod.explanation
    }
    
    func fetchAPOD() async {
        state = .loading
        
        do {
            let apod = try await APODManager.shared.getApod()
            state = .success(apod)
        } catch {
            state = .failure(error)
        }
    }
    
    private func dateToString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
}

