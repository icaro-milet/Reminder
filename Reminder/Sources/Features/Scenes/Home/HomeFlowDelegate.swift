//
//  HomeFlowDelegate.swift
//  Reminder
//
//  Created by milet on 24/06/25.
//

public protocol HomeFlowDelegate: AnyObject {
    func navigateToRecipes()
    func navigateToMyReceipts()
    func logout()
}
