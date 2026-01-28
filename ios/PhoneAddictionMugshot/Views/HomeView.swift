//
//  HomeView.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var screenTimeManager: ScreenTimeManager
    @Binding var showingMugshotPrompt: Bool
    @Binding var selectedTab: Int
    @State private var showingPermissionRequest = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Premium gradient background
                LinearGradient(
                    colors: [Color(hex: "1a1a2e"), Color(hex: "16213e"), Color(hex: "0f3460")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 8) {
                            Text("Phone Addiction")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("MUGSHOT")
                                .font(.system(size: 42, weight: .black, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        .padding(.top, 40)
                        
                        // Stats card - Always shown now
                        VStack(spacing: 24) {
                            // Screen time display
                            VStack(spacing: 12) {
                                Text("Today's Screen Time")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    Text("\(screenTimeManager.screenTimeHours)")
                                        .font(.system(size: 72, weight: .black, design: .rounded))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: screenTimeManager.screenTimeHours >= 4 ? 
                                                    [Color(hex: "e94560"), Color(hex: "ff6b9d")] :
                                                    [Color(hex: "4ecdc4"), Color(hex: "44a08d")],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                    
                                    Text("hrs")
                                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white.opacity(0.6))
                                        .padding(.bottom, 8)
                                }
                                
                                // Progress bar
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Capsule()
                                            .fill(Color.white.opacity(0.1))
                                            .frame(height: 8)
                                        
                                        Capsule()
                                            .fill(
                                                LinearGradient(
                                                    colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .frame(
                                                width: min(CGFloat(screenTimeManager.screenTimeHours) / 8.0 * geometry.size.width, geometry.size.width),
                                                height: 8
                                            )
                                    }
                                }
                                .frame(height: 8)
                            }
                            
                            Divider()
                                .background(Color.white.opacity(0.2))
                            
                            // Mugshot count
                            HStack(spacing: 40) {
                                VStack(spacing: 8) {
                                    Text("\(screenTimeManager.screenTimeHours)")
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("Mugshots Today")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                
                                Divider()
                                    .frame(height: 50)
                                    .background(Color.white.opacity(0.2))
                                
                                VStack(spacing: 8) {
                                    Text("😱")
                                        .font(.system(size: 36))
                                    
                                    Text("How You Look")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                            }
                            
                            // Manual capture button
                            Button(action: {
                                showingMugshotPrompt = true
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 20, weight: .semibold))
                                    
                                    Text("Take Mugshot Now")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(16)
                            }
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white.opacity(0.08))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(
                                            LinearGradient(
                                                colors: [Color.white.opacity(0.3), Color.white.opacity(0.1)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                        )
                        .padding(.horizontal, 20)
                        
                        // Info cards
                        VStack(spacing: 16) {
                            InfoCard(
                                icon: "bell.fill",
                                title: "Hourly Reminders",
                                description: "Taking a mugshot every \(Int(screenTimeManager.reminderIntervalHours * 60)) minutes",
                                action: {
                                    // Navigate to Settings tab
                                    selectedTab = 2
                                }
                            )
                            
                            InfoCard(
                                icon: "photo.stack.fill",
                                title: "Build Your Collection",
                                description: "See the progression of your expressions throughout the day",
                                action: {
                                    // Navigate to Gallery tab
                                    selectedTab = 1
                                }
                            )
                            
                            InfoCard(
                                icon: "square.and.arrow.up.fill",
                                title: "Share the Shame",
                                description: "Share your mugshots to hold yourself accountable",
                                action: {
                                    // Navigate to Gallery tab
                                    selectedTab = 1
                                    
                                    // Dispatch notification to trigger share sheet in GalleryView
                                    // Delay slightly to allow tab switch
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        NotificationCenter.default.post(name: NSNotification.Name("ShareShameRequested"), object: nil)
                                    }
                                }
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let description: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.1))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(description)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                if action != nil {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white.opacity(0.3))
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
        .disabled(action == nil)
        .buttonStyle(PlainButtonStyle())
    }
}

// Color extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    HomeView(
        screenTimeManager: ScreenTimeManager(),
        showingMugshotPrompt: .constant(false),
        selectedTab: .constant(0)
    )
}
