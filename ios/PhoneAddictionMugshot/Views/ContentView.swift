//
//  ContentView.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var screenTimeManager: ScreenTimeManager
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var storageManager = MugshotStorageManager()
    @EnvironmentObject var analyticsManager: AnalyticsManager
    
    @State private var selectedTab = 0
    @State private var showingMugshotPrompt = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView(
                    screenTimeManager: screenTimeManager,
                    showingMugshotPrompt: $showingMugshotPrompt,
                    selectedTab: $selectedTab
                )
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
                
                GalleryView(storageManager: storageManager)
                    .tabItem {
                        Label("Gallery", systemImage: "photo.stack.fill")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .tag(2)
            }
            .accentColor(.purple)
        }
        .sheet(isPresented: $showingMugshotPrompt) {
            MugshotCaptureView(
                cameraManager: cameraManager,
                storageManager: storageManager,
                screenTimeHours: screenTimeManager.screenTimeHours,
                isPresented: $showingMugshotPrompt
            )
        }
        .onChange(of: screenTimeManager.shouldTakeMugshot) { oldValue, newValue in
            if newValue {
                showingMugshotPrompt = true
                screenTimeManager.resetMugshotTrigger()
                analyticsManager.track(event: "mugshot_prompt_shown", properties: [
                    "screen_time_hours": screenTimeManager.screenTimeHours
                ])
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(ScreenTimeManager())
        .environmentObject(AnalyticsManager())
}
