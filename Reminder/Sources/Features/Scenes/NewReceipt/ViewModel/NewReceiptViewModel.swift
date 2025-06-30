//
//  NewReceiptViewModel.swift
//  Reminder
//
//  Created by milet on 30/06/25.
//

import Foundation

class NewReceiptViewModel {
    func addReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        DBHelper.share.insertRecipe(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)
    }
}
