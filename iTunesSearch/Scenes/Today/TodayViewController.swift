//
//  TodayViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol TodayViewProtocol: AnyObject {
    
}

final class TodayViewController: UIViewController {
    
    var presenter: TodayPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension TodayViewController: TodayViewProtocol {
    
}
