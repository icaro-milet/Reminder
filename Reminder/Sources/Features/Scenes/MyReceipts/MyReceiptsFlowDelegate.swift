//
//  MyReceiptsFlowDelegate.swift
//  Reminder
//
//  Created by milet on 01/07/25.
//

import Foundation
import UIKit

public protocol MyReceiptsFlowDelegate: AnyObject {
    func goToNewReceipts()
    func popScreen()
}
