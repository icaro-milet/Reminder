//
//  LoginBottomSheetViewDelegate.swift
//  Reminder
//
//  Created by milet on 12/06/25.
//

import Foundation
import UIKit

protocol LoginBottomSheetViewDelegate: AnyObject {
    func sendLoginData(username: String, password: String)
}
