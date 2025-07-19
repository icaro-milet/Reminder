//
//  User.swift
//  Reminder
//
//  Created by milet on 14/06/25.
//

import Foundation

struct User: Codable {
    
    let email: String
    let isUserSaved: Bool
    let hasFaceIdEnabled: Bool
}
