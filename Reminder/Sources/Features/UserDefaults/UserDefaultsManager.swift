//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by milet on 14/06/25.
//

import Foundation
import UIKit

class UserDefaultsManager {
    
    private static let userKey = "userKey"
    private static let userNameKey = "userNameKey"
    private static let profileImageKey = "profileImageKey"
    private static let onboardingSeenKey = "onboardingSeenKey"
    
    static func saveUser(user: User) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveProileImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: profileImageKey)
        }
    }
    
    static func loadProfileImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: profileImageKey) {
            return UIImage(data: imageData)
        }
        
        return UIImage(named: "user")
    }
    
    static func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: userKey) {
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
        }
        
        return nil
    }
    
    static func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: profileImageKey)
        UserDefaults.standard.synchronize()
    }
    
    static func removeUserName() {
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func markOnboardingSeen() {
        UserDefaults.standard.set(true, forKey: onboardingSeenKey)
        UserDefaults.standard.synchronize()
    }
    
    static func hasSeenOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: onboardingSeenKey)
    }
}
