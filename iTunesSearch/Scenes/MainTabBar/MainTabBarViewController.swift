//
//  MainTabBarViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([
            createNavController(viewController: TodayBuilder.start(), title: "Today", imageName: "doc.text.image"),
            createNavController(viewController: AppsBuilder.start(), title: "Apps", imageName: "square.stack.3d.up.fill"),
            createNavController(viewController: AppsSearchBuilder.start(), title: "Search", imageName: "magnifyingglass")], animated: true)
    }
}
