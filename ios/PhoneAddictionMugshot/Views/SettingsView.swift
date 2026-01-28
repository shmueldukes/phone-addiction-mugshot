//
//  SettingsView.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var screenTimeManager: ScreenTimeManager
    @State private var showingSupportOptions = false
    @AppStorage("isBiometricEnabled") private var isBiometricEnabled = false
    
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
                    VStack(spacing: 24) {
                        // App icon and info
                        VStack(spacing: 12) {
                            Image(systemName: "camera.macro.circle.fill")
                                .font(.system(size: 80))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                            Text("Phone Addiction Mugshot")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Version 1.0")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                        
                        // Settings sections
                        VStack(spacing: 16) {
                            SettingsSection(title: "Reminders") {
                                HStack {
                                    HStack(spacing: 16) {
                                        Image(systemName: "timer")
                                            .font(.system(size: 20))
                                            .foregroundStyle(
                                                LinearGradient(
                                                    colors: [.purple, .pink],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 40, height: 40)
                                            .background(
                                                Circle()
                                                    .fill(Color.white.opacity(0.1))
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Reminder Interval")
                                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Picker("", selection: $screenTimeManager.reminderIntervalHours) {
                                        Text("1 min (Test)").tag(0.017) // For testing
                                        Text("15 min").tag(0.25)
                                        Text("30 min").tag(0.5)
                                        Text("1 hour").tag(1.0)
                                        Text("2 hours").tag(2.0)
                                        Text("4 hours").tag(4.0)
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .accentColor(.white)
                                }
                                .padding(16)
                                
                                Button(action: {
                                    NotificationManager.shared.scheduleTestNotification()
                                }) {
                                    Text("Send Test Notification (5s)")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color(hex: "e94560"))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(Color.white.opacity(0.05))
                                }
                            }
                            
                            SettingsSection(title: "Security") {
                                HStack {
                                    HStack(spacing: 16) {
                                        Image(systemName: "faceid")
                                            .font(.system(size: 20))
                                            .foregroundStyle(
                                                LinearGradient(
                                                    colors: [.purple, .pink],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 40, height: 40)
                                            .background(
                                                Circle()
                                                    .fill(Color.white.opacity(0.1))
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Secure Gallery")
                                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                                .foregroundColor(.white)
                                            
                                            Text("Require FaceID to view mugshots")
                                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                                .foregroundColor(.white.opacity(0.6))
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $isBiometricEnabled)
                                        .toggleStyle(SwitchToggleStyle(tint: Color(hex: "e94560")))
                                }
                                .padding(16)
                            }
                            
                            SettingsSection(title: "Support") {
                                SettingsRow(
                                    icon: "envelope.fill",
                                    title: "Contact Support",
                                    subtitle: "We're here to help"
                                ) {
                                    showingSupportOptions = true
                                }
                                
                                SettingsRow(
                                    icon: "star.fill",
                                    title: "Rate the App",
                                    subtitle: "Share your feedback"
                                ) {
                                    rateApp()
                                }
                            }
                            
                            SettingsSection(title: "Legal") {
                                SettingsRow(
                                    icon: "doc.text.fill",
                                    title: "Privacy Policy",
                                    subtitle: "How we protect your data"
                                ) {
                                    openPrivacyPolicy()
                                }
                                
                                SettingsRow(
                                    icon: "doc.text.fill",
                                    title: "Terms of Service",
                                    subtitle: "Usage agreement"
                                ) {
                                    openTerms()
                                }
                                
                                SettingsRow(
                                    icon: "checkmark.seal.fill",
                                    title: "EULA",
                                    subtitle: "End User License Agreement"
                                ) {
                                    openEULA()
                                }
                            }
                            
                            SettingsSection(title: "About") {
                                VStack(spacing: 12) {
                                    Text("Developed by")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.6))
                                    
                                    Text("Conflux Solutions LLC")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                    
                                    Text("Making phone addiction visible, one mugshot at a time.")
                                        .font(.system(size: 14, weight: .regular, design: .rounded))
                                        .foregroundColor(.white.opacity(0.7))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .confirmationDialog("Contact Support", isPresented: $showingSupportOptions, titleVisibility: .visible) {
            Button("Send Email") {
                openEmailClient()
            }
            
            Button("Submit Support Form") {
                openSupportForm()
            }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose how you'd like to contact our support team at helpdesk@confluxsolutions.com")
        }
    }
    
    func openEmailClient() {
        let email = "helpdesk@confluxsolutions.com"
        let subject = "Phone Addiction Mugshot - Support Request"
        let body = """
        
        
        ---
        App Version: 1.0
        Device: \(UIDevice.current.model)
        iOS Version: \(UIDevice.current.systemVersion)
        """
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)") {
            UIApplication.shared.open(url)
        }
    }
    
    func openSupportForm() {
        // Open Microsoft Forms support form
        if let url = URL(string: "https://forms.cloud.microsoft/r/BqhxrSrHk8") {
            UIApplication.shared.open(url)
        }
    }
    
    func rateApp() {
        // Open App Store rating page
        if let url = URL(string: "https://apps.apple.com/app/id123456789?action=write-review") {
            UIApplication.shared.open(url)
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://confluxsolutions.app/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    func openTerms() {
        if let url = URL(string: "https://confluxsolutions.app/terms-of-service") {
            UIApplication.shared.open(url)
        }
    }
    
    func openEULA() {
        if let url = URL(string: "https://confluxsolutions.app/eula") {
            UIApplication.shared.open(url)
        }
    }
}

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.5))
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                content
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.1))
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.3))
            }
            .padding(16)
        }
    }
}

#Preview {
    SettingsView()
}
