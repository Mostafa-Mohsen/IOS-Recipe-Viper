//
//  DetailsPresenter.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

class DetailsPresenter: DetailsViewToPresenterProtocol {
    var view: DetailsPresenterToViewProtocol?
    var interactor: DetailsPresenterToInteractorProtocol?
    var router: DetailsPresenterToRouterProtocol?
    
    func openLink(navigationConroller:UINavigationController,uri:String) {
        router?.openLink(navigationConroller: navigationConroller, uri: uri)
    }
}

extension DetailsPresenter: DetailsInteractorToPresenterProtocol{
    
}
