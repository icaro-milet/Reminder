//
//  String+Ext.swift
//  Reminder
//
//  Created by milet on 11/06/25.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
