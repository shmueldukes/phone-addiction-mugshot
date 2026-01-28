//
//  PhoneAddictionMugshotApp.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI
import FamilyControls

@main
struct PhoneAddictionMugshotApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var screenTimeManager = ScreenTimeManager()
    @StateObject private var analyticsManager = AnalyticsManager()
    
    init() {
        // Initialize analytics
        AnalyticsManager.initialize()
        // Request notification permission
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(screenTimeManager)
                .environmentObject(analyticsManager)
                .onOpenURL { url in
                    handleDeepLink(url)
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("TriggerMugshot"))) { _ in
                    screenTimeManager.shouldTakeMugshot = true
                }
        }
    }
    
    private func handleDeepLink(_ url: URL) {
        // Handle deep links for shared mugshots
        analyticsManager.track(event: "deep_link_opened", properties: ["url": url.absoluteString])
    }
}

// Delegate to handle foreground notifications
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // Show notification even when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // Handle tap on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "mugshot_reminder" {
            // Post notification to trigger mugshot
            NotificationCenter.default.post(name: Notification.Name("TriggerMugshot"), object: nil)
        }
        completionHandler()
    }
}
