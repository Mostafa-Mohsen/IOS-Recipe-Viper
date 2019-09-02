//
//  File.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewToPresenterProtocol: class{
    var view: DetailsPresenterToViewProtocol? {get set}
    var interactor: DetailsPresenterToInteractorProtocol? {get set}
    var router: DetailsPresenterToRouterProtocol? {get set}
    
    func openLink(navigationConroller:UINavigationController,uri:String)
}

protocol DetailsPresenterToViewProtocol: class{
    
}

protocol DetailsPresenterToRouterProtocol: class {
    static func createModule() -> DetailsTableViewController
    func openLink(navigationConroller:UINavigationController,uri:String)
}

protocol DetailsPresenterToInteractorProtocol: class {
    var presenter: DetailsInteractorToPresenterProtocol? {get set}
    
}

protocol DetailsInteractorToPresenterProtocol: class {
    
}

