//
//  ScreenTimeManager.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings

class ScreenTimeManager: ObservableObject {
    @Published var isAuthorized = true // Always authorized since we aren't using actual Screen Time API yet
    @Published var totalScreenTime: TimeInterval = 0
    @Published var screenTimeHours: Int = 0
    @Published var shouldTakeMugshot = false
    @Published var reminderIntervalHours: Double = 1.0 {
        didSet {
            startTimer()
        }
    }
    
    private let center = AuthorizationCenter.shared
    private var lastKnownHour = 0
    
    private var timer: Timer?
    
    init() {
        startTimer()
    }
    
    func checkAuthorization() {
        isAuthorized = true
    }
    
    func requestAuthorization() async throws {
        // Mock success
        await MainActor.run {
            self.isAuthorized = true
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        let interval = reminderIntervalHours * 3600
        
        // Schedule notification for background awareness
        NotificationManager.shared.scheduleRecurringNotification(interval: interval)
        
        // Use a repeating timer for foreground awareness
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.shouldTakeMugshot = true
            }
        }
    }
    
    func updateInterval(_ hours: Double) {
        reminderIntervalHours = hours
        // startTimer() is called by didSet
    }
    
    /// Monitor screen time and trigger mugshot when crossing an hour threshold
    func updateScreenTime(_ seconds: TimeInterval) {
        // ... handled by timer now mostly, but keeping for reference if we get real data
        totalScreenTime = seconds
        screenTimeHours = Int(seconds / 3600)
    }
    
    func resetMugshotTrigger() {
        shouldTakeMugshot = false
    }
}
