//
//  AppsViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol AppsViewProtocol: AnyObject {
    
}

class AppsViewController: UIViewController {
    
    var presenter: AppsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AppsViewController: AppsViewProtocol {
    
}
