//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by milet on 14/06/25.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    
    func makeNewRecipesViewController() -> NewReceiptViewController {
        let viewController = NewReceiptViewController()
        
        return viewController
    }
    
    
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let contentView = SplashView()
        let viewController = SplashViewController(contentView: contentView,
                                                  flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(contentView: contentView,
                                                            flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView,
                                                flowDelegate: flowDelegate,
                                                viewModel: HomeViewModel())
        
        return viewController
    }
    
    func makeMyRecipesViewController(flowDelegate: any MyReceiptsFlowDelegate) -> MyReceiptsViewController {
        let contentView = MyReceiptsView()
        let viewController = MyReceiptsViewController(contentView: contentView,
                                                      flowDelegate: flowDelegate)
        
        return viewController
    }
}
