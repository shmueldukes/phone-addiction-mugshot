//
//  CameraManager.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit

class CameraManager: NSObject, ObservableObject {
    @Published var capturedImage: UIImage?
    @Published var isCameraAuthorized = false
    @Published var showCamera = false
    
    private var captureSession: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    @Published var permissionStatus: AVAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        checkCameraAuthWithSimulatorFallback()
    }
    
    func checkCameraAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        DispatchQueue.main.async {
            self.permissionStatus = status
            self.isCameraAuthorized = (status == .authorized)
        }
        
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.isCameraAuthorized = granted
                    self.permissionStatus = granted ? .authorized : .denied
                }
            }
        }
    }
    
    func setupCamera() {
        guard isCameraAuthorized else { return }
        
        if isSimulator { return } // Simulator has no camera setup needed beyond auth
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: frontCamera) else { return }
        
        photoOutput = AVCapturePhotoOutput()
        
        if captureSession?.canAddInput(input) == true {
            captureSession?.addInput(input)
        }
        
        if let photoOutput = photoOutput, captureSession?.canAddOutput(photoOutput) == true {
            captureSession?.addOutput(photoOutput)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
    }
    
    func capturePhoto() {
        if isSimulator {
            mockCapture()
            return
        }
        
        guard let photoOutput = photoOutput else { return }
        
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        guard let captureSession = captureSession else { return nil }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }
    
    func stopCamera() {
        captureSession?.stopRunning()
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        DispatchQueue.main.async {
            self.capturedImage = image
            self.showCamera = false
        }
    }
}

// Helper to detect simulator
var isSimulator: Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}

extension CameraManager {
    // Override authorization for simulator
    func checkCameraAuthWithSimulatorFallback() {
        if isSimulator {
            DispatchQueue.main.async {
                self.isCameraAuthorized = true
            }
        } else {
            checkCameraAuthorization()
        }
    }
    
    // Mock capture for simulator
    func mockCapture() {
        guard isSimulator else { return }
        
        // Create a dummy "mugshot" image
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1080, height: 1920))
        let image = renderer.image { context in
            UIColor.darkGray.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1080, height: 1920))
            
            // Draw a face emoji
            let string = "🤨"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 400),
                .foregroundColor: UIColor.white
            ]
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            let stringSize = attributedString.size()
            attributedString.draw(at: CGPoint(x: (1080 - stringSize.width) / 2, y: (1920 - stringSize.height) / 2))
            
            // Draw text
            let text = "Simulator Mock Mugshot"
            let textAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 60, weight: .bold),
                .foregroundColor: UIColor.white
            ]
            let textStr = NSAttributedString(string: text, attributes: textAttrs)
            let textSize = textStr.size()
            textStr.draw(at: CGPoint(x: (1080 - textSize.width) / 2, y: 1500))
        }
        
        DispatchQueue.main.async {
            self.capturedImage = image
            self.showCamera = false
        }
    }
}
