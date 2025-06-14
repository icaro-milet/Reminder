//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by milet on 14/06/25.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let viewController = SplashViewController(flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    
}
