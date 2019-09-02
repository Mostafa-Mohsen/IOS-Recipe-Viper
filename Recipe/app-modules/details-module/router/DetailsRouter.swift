//
//  DetailsRouter.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class DetailsRouter: DetailsPresenterToRouterProtocol {
    
    static func createModule() -> DetailsTableViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsTableViewController
        let presenter: DetailsViewToPresenterProtocol & DetailsInteractorToPresenterProtocol = DetailsPresenter()
        let interactor: DetailsPresenterToInteractorProtocol = DetailsInteractor()
        let router: DetailsPresenterToRouterProtocol = DetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func openLink(navigationConroller:UINavigationController,uri:String) {
        let url = URL(string: uri)
        if let urlLink = url {
            let safari = SFSafariViewController.init(url: urlLink)
            navigationConroller.present(safari, animated: true, completion: nil)
        }
    }
}
