//
//  BiometricManager.swift
//  PhoneAddictionMugshot
//
//  Created by Conflux Solutions LLC
//  Copyright © 2026 Conflux Solutions LLC. All rights reserved.
//

import Foundation
import LocalAuthentication

class BiometricManager: ObservableObject {
    static let shared = BiometricManager()
    @Published var isUnlocked = false
    @Published var biometricType: LABiometryType = .none
    
    private let context = LAContext()
    
    private init() {
        checkBiometricType()
    }
    
    func checkBiometricType() {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            biometricType = context.biometryType
        } else {
            biometricType = .none
        }
    }
    
    func authenticate(completion: @escaping (Bool) -> Void) {
        var error: NSError?
        
        // Reset context to ensure fresh prompt if needed
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock to view your mugshot gallery"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    self.isUnlocked = success
                    completion(success)
                }
            }
        } else {
            // Fallback if biometrics not available (or simulator)
            // For simulator development convenience, we'll treat unavailable as authorized if in debug
            #if targetEnvironment(simulator)
            DispatchQueue.main.async {
                self.isUnlocked = true
                completion(true)
            }
            #else
            DispatchQueue.main.async {
                self.isUnlocked = false
                completion(false)
            }
            #endif
        }
    }
    
    func lock() {
        isUnlocked = false
    }
}
