//
//  MyReceiptsViewModel.swift
//  Reminder
//
//  Created by milet on 02/07/25.
//

import Foundation
import UIKit

class MyReceiptsViewModel {
    func fetchData() -> [Medicine] {
        return DBHelper.share.fetchReceipts()
    }
}
