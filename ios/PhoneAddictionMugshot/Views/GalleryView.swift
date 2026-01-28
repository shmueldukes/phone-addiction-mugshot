//
//  GalleryView.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI

struct GalleryView: View {
    @ObservedObject var storageManager: MugshotStorageManager
    @State private var selectedMugshot: Mugshot?
    @State private var showingShareSheet = false
    @State private var shareItems: [Any] = []
    @State private var showingShareOptions = false
    
    // Selection Mode State
    @State private var isSelectionMode = false
    @State private var selectedMugshotIds: Set<UUID> = []
    
    @AppStorage("isBiometricEnabled") private var isBiometricEnabled = false
    @State private var isUnlocked = false
    @State private var isAuthenticating = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                
                if isBiometricEnabled && !isUnlocked {
                    // Locked State
                    lockScreen
                } else {
                    // Unlocked Content
                    if storageManager.mugshots.isEmpty {
                        emptyState
                    } else {
                        galleryContent
                    }
                }
            }
            .navigationTitle(isSelectionMode ? "\(selectedMugshotIds.count) Selected" : "Your Mugshots")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isSelectionMode ? "Done" : "Select") {
                        isSelectionMode.toggle()
                        selectedMugshotIds.removeAll()
                    }
                }
                
                if isSelectionMode {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Share") {
                            createAndShareCollage()
                        }
                        .disabled(selectedMugshotIds.isEmpty)
                    }
                }
            }
            .sheet(isPresented: $showingShareSheet) {
                ShareSheet(activityItems: shareItems, applicationActivities: nil)
            }
        }
        .sheet(item: $selectedMugshot) { mugshot in
            MugshotDetailView(
                mugshot: mugshot,
                storageManager: storageManager,
                showingShareSheet: $showingShareSheet // This binding might need check if used by DetailView for collage
            )
        }
        .onAppear {
            if isBiometricEnabled && !isUnlocked {
                authenticate()
            }
        }
    }
    
    var lockScreen: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.fill")
                .font(.system(size: 60))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text("Gallery Locked")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Button(action: authenticate) {
                Text("Unlock with FaceID")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
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
    }
    
    var emptyState: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text("No Mugshots Yet")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Your phone addiction mugshots will appear here")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    var galleryContent: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(storageManager.mugshots) { mugshot in
                        MugshotThumbnail(mugshot: mugshot, isSelected: selectedMugshotIds.contains(mugshot.id), isSelectionMode: isSelectionMode)
                            .onTapGesture {
                                if isSelectionMode {
                                    if selectedMugshotIds.contains(mugshot.id) {
                                        selectedMugshotIds.remove(mugshot.id)
                                    } else {
                                        selectedMugshotIds.insert(mugshot.id)
                                    }
                                } else {
                                    selectedMugshot = mugshot
                                }
                            }
                    }
                }
                .padding()
                .padding(.top, 20)
            }
            
            if !isSelectionMode {
                Button(action: {
                    showingShareOptions = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text("Share the Shame")
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
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                .confirmationDialog("Share the Shame", isPresented: $showingShareOptions, titleVisibility: .visible) {
                    Button("Share Latest Mugshot") {
                        if let latest = storageManager.mugshots.first {
                            selectedMugshot = latest
                        }
                    }
                    
                    Button("Collage Today's Mugshots") {
                        selectTodaysMugshots()
                    }
                    
                    Button("Select Manually...") {
                        isSelectionMode = true
                        selectedMugshotIds.removeAll()
                    }
                    
                    Button("Cancel", role: .cancel) { }
                }
            }
        }
    }
    
    func selectTodaysMugshots() {
        let todayMugshots = storageManager.getMugshots(for: Date())
        if todayMugshots.isEmpty {
            // If no mugshots today, maybe show an alert or just open manual selection
            isSelectionMode = true
            selectedMugshotIds.removeAll()
        } else {
            selectedMugshotIds = Set(todayMugshots.map { $0.id })
            isSelectionMode = true
        }
    }
    
    func createAndShareCollage() {
        let selectedMugshots = storageManager.mugshots.filter { selectedMugshotIds.contains($0.id) }
        let images = selectedMugshots.compactMap { $0.image }
        
        if let collage = CollageManager.shared.createCollage(from: images) {
            shareItems = [collage]
            showingShareSheet = true
        }
    }
    
    func authenticate() {
        guard !isAuthenticating else { return }
        isAuthenticating = true
        
        BiometricManager.shared.authenticate { success in
            isAuthenticating = false
            if success {
                isUnlocked = true
            }
        }
    }
}

struct MugshotThumbnail: View {
    let mugshot: Mugshot
    var isSelected: Bool = false
    var isSelectionMode: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                if let image = mugshot.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 200)
                }
                
                if isSelectionMode {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 24))
                        .foregroundColor(isSelected ? .green : .white)
                        .background(Circle().fill(Color.black.opacity(0.5)))
                        .padding(8)
                }
            }
            
            VStack(spacing: 4) {
                Text("\(mugshot.screenTimeHours) hours")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(mugshot.timestamp, style: .time)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.3))
        }
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.green : Color.white.opacity(0.2), lineWidth: isSelected ? 3 : 1)
        )
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .scaleEffect(isSelected ? 0.95 : 1.0)
        .animation(.spring(), value: isSelected)
    }
}

struct MugshotDetailView: View {
    let mugshot: Mugshot
    @ObservedObject var storageManager: MugshotStorageManager
    @Binding var showingShareSheet: Bool
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: { showingDeleteAlert = true }) {
                        Image(systemName: "trash")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding()
                
                Spacer()
                
                if let image = mugshot.image {
                    VStack(spacing: 20) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                            )
                            .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                        
                        VStack(spacing: 8) {
                            Text("After \(mugshot.screenTimeHours) hours")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text(mugshot.timestamp, style: .date)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text(mugshot.timestamp, style: .time)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    shareImage()
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text("Share Your Shame")
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
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
        .alert("Delete Mugshot", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                storageManager.deleteMugshot(mugshot)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this mugshot?")
        }
    }
    
    func shareImage() {
        guard let image = mugshot.image else { return }
        
        // Add text overlay to image
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let imageWithText = renderer.image { context in
            image.draw(at: .zero)
            
            let text = "After \(mugshot.screenTimeHours) hours on my phone 😱\n\nGet Phone Addiction Mugshot"
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40, weight: .bold),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle,
                .strokeColor: UIColor.black,
                .strokeWidth: -3
            ]
            
            let textRect = CGRect(x: 0, y: image.size.height - 200, width: image.size.width, height: 200)
            text.draw(in: textRect, withAttributes: attrs)
        }
        
        let activityVC = UIActivityViewController(
            activityItems: [imageWithText, URL(string: "phoneaddictionmugshot://share")!],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            // Find the top-most view controller
            var topController = rootVC
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(activityVC, animated: true)
        }
    }
}

// SwiftUI wrapper for UIActivityViewController
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    GalleryView(storageManager: MugshotStorageManager())
}
