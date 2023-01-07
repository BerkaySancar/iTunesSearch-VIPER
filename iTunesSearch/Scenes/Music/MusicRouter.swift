//
//  MusicRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import Foundation
import UIKit

protocol MusicRouterProtocol: AnyObject {
    
}

final class MusicRouter: MusicRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
