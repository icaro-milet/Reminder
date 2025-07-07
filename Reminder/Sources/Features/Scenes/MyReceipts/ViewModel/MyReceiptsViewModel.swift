//
//  MyReceiptsViewModel.swift
//  Reminder
//
//  Created by milet on 02/07/25.
//

import Foundation
import UIKit
import UserNotifications

class MyReceiptsViewModel {
    func fetchData() -> [Medicine] {
        return DBHelper.share.fetchReceipts()
    }
    
    func deleteReceipt(byId id: Int) {
        DBHelper.share.deleteReceipt(byId: id)
    }
    
    func removeNotifications(for remedy: String) {
        let center = UNUserNotificationCenter.current()
        let identifiers = (0..<6).map { "\(remedy)-\($0)" }
        
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        
        print("Notificações para \(identifiers) removidas")
    }
}
