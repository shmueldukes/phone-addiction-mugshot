//
//  MugshotCaptureView.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI
import AVFoundation

struct MugshotCaptureView: View {
    @ObservedObject var cameraManager: CameraManager
    @ObservedObject var storageManager: MugshotStorageManager
    let screenTimeHours: Int
    @Binding var isPresented: Bool
    
    @State private var countdown = 3
    @State private var isCountingDown = false
    @State private var capturedImage: UIImage?
    @State private var showCaptured = false
    
    var body: some View {
        ZStack {
            // Dark background
            Color.black.ignoresSafeArea()
            
            if showCaptured, let image = capturedImage {
                // Show captured image
                VStack(spacing: 30) {
                    Text("Your Mugshot")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 60)
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        )
                        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                    
                    Text("after \(screenTimeHours) hours on your phone")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            capturedImage = nil
                            showCaptured = false
                            isCountingDown = false
                            cameraManager.setupCamera()
                        }) {
                            Text("Retake")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(16)
                        }
                        
                        Button(action: {
                            storageManager.saveMugshot(image: image, screenTimeHours: screenTimeHours)
                            isPresented = false
                        }) {
                            Text("Save")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
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
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
                }
            } else if cameraManager.permissionStatus == .denied || cameraManager.permissionStatus == .restricted {
                // Permission Denied View
                VStack(spacing: 24) {
                    Spacer()
                    
                    Image(systemName: "camera.trianglebadge.exclamationmark.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
                        
                    Text("Camera Access Required")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("We need camera access to capture your mugshot.\nPlease enable it in Settings.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Button(action: {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Grant Access")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.bottom, 40)
                }
            } else {
                // Camera preview comes FIRST so it's behind the UI
                CameraPreview(cameraManager: cameraManager)
                    .ignoresSafeArea()
                
                // UI Overlay
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    // Countdown overlay
                    if isCountingDown {
                        Text("\(countdown)")
                            .font(.system(size: 120, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("After \(screenTimeHours) hours...")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Time for your mugshot! 📸")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                        
                        Button(action: startCountdown) {
                            HStack(spacing: 12) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("Capture")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "e94560"), Color(hex: "ff6b9d")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(30)
                            .shadow(color: Color(hex: "e94560").opacity(0.5), radius: 20, x: 0, y: 10)
                        }
                        .disabled(isCountingDown)
                    }
                    .padding(.bottom, 60)
                }
            }
        }
        .onAppear {
            if cameraManager.isCameraAuthorized {
                cameraManager.setupCamera()
            } else {
                cameraManager.checkCameraAuthorization()
            }
        }
        .onDisappear {
            cameraManager.stopCamera()
        }
        .onChange(of: cameraManager.capturedImage) { oldValue, newValue in
            if let image = newValue {
                capturedImage = image
                showCaptured = true
            }
        }
        .onChange(of: cameraManager.isCameraAuthorized) { oldValue, newValue in
            if newValue {
                cameraManager.setupCamera()
            }
        }
    }
    
    func startCountdown() {
        isCountingDown = true
        countdown = 3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if countdown > 1 {
                countdown -= 1
            } else {
                timer.invalidate()
                cameraManager.capturePhoto()
                isCountingDown = false
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraManager: CameraManager
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        
        if let previewLayer = cameraManager.getPreviewLayer() {
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            DispatchQueue.main.async {
                previewLayer.frame = uiView.bounds
            }
        }
    }
}

import AVFoundation

#Preview {
    MugshotCaptureView(
        cameraManager: CameraManager(),
        storageManager: MugshotStorageManager(),
        screenTimeHours: 3,
        isPresented: .constant(true)
    )
}
