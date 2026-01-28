//
//  MugshotStorageManager.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI
import UIKit

struct Mugshot: Identifiable, Codable {
    let id: UUID
    let imageName: String
    let timestamp: Date
    let screenTimeHours: Int
    
    var image: UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let imageURL = documentsDirectory.appendingPathComponent(imageName)
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return UIImage(data: imageData)
    }
}

class MugshotStorageManager: ObservableObject {
    @Published var mugshots: [Mugshot] = []
    
    private let mugshotsKey = "saved_mugshots"
    
    init() {
        loadMugshots()
    }
    
    func saveMugshot(image: UIImage, screenTimeHours: Int) {
        let id = UUID()
        let imageName = "\(id.uuidString).jpg"
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let imageURL = documentsDirectory.appendingPathComponent(imageName)
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            try? imageData.write(to: imageURL)
        }
        
        let mugshot = Mugshot(
            id: id,
            imageName: imageName,
            timestamp: Date(),
            screenTimeHours: screenTimeHours
        )
        
        mugshots.insert(mugshot, at: 0)
        saveMugshotsMetadata()
    }
    
    func deleteMugshot(_ mugshot: Mugshot) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let imageURL = documentsDirectory.appendingPathComponent(mugshot.imageName)
        try? FileManager.default.removeItem(at: imageURL)
        
        mugshots.removeAll { $0.id == mugshot.id }
        saveMugshotsMetadata()
    }
    
    private func saveMugshotsMetadata() {
        if let encoded = try? JSONEncoder().encode(mugshots) {
            UserDefaults.standard.set(encoded, forKey: mugshotsKey)
        }
    }
    
    private func loadMugshots() {
        guard let data = UserDefaults.standard.data(forKey: mugshotsKey),
              let decoded = try? JSONDecoder().decode([Mugshot].self, from: data) else {
            return
        }
        mugshots = decoded
    }
    func getMugshots(for date: Date) -> [Mugshot] {
        let calendar = Calendar.current
        return mugshots.filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
    }
}
