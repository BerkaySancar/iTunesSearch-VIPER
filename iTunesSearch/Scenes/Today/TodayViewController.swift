//
//  TodayViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol TodayViewProtocol: AnyObject {
    
    func prepareCollectionView()
    func prepareActivityIndicatorView()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showData(appGroup: [AppGroup])
}

protocol DailyListCellDelegate: AnyObject {
    func selectedApp(id: String)
}

final class TodayViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        aiv.color = .label
        return aiv
    }()
    
    internal var presenter: TodayPresenterProtocol!
    
    private var cellStartingFrame: CGRect?
    private var appFullscreenController: TodayCellController!
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var appGroup: [AppGroup] = []

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        presenter.viewDidLoad()
    }
}

// MARK: - View Protocol
extension TodayViewController: TodayViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DailyListCell.self, forCellWithReuseIdentifier: DailyListCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.anchor(top: view.topAnchor, leading: view.leftAnchor, trailing: view.rightAnchor, bottom: view.bottomAnchor)
    }
    
    func prepareActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchor(top: view.topAnchor, leading: view.leftAnchor, trailing: view.rightAnchor, bottom: view.bottomAnchor)
    }
    
    func beginRefreshing() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
        
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onError(message: String) {
        DispatchQueue.main.async {
            self.showError(message: message)
        }
    }
    
    func showData(appGroup: [AppGroup]) {
        self.appGroup = appGroup
    }
}

// MARK: - DailyListCell Delegate
extension TodayViewController: DailyListCellDelegate {
    func selectedApp(id: String) {
        self.presenter.didSelectApp(id: id)
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyListCell.identifier, for: indexPath) as? DailyListCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemBackground
        let group = self.appGroup[indexPath.item]
        cell.design(appGroup: group)
        cell.delegate = self
        cell.layer.shadowOpacity = 0.3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 440)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentAnimatedController(indexPath: indexPath)
    }
}

// MARK: ANIMATED TODAY CELL CONTROLLER
extension TodayViewController {
    fileprivate func presentAnimatedController(indexPath: IndexPath) {
        let fullscreenController = TodayCellController()
        fullscreenController.appGroup = appGroup[indexPath.row].feed.results
        fullscreenController.dismissHandler = {
            self.handleRemovedView()
        }
        let fullscreenControllerView = fullscreenController.view!
        fullscreenControllerView.layer.cornerRadius = 16
        view.addSubview(fullscreenControllerView)
        addChild(fullscreenController)

        self.appFullscreenController = fullscreenController
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.cellStartingFrame = startingFrame
        
        fullscreenControllerView.translatesAutoresizingMaskIntoConstraints = false
        self.topConstraint = fullscreenControllerView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        self.leadingConstraint = fullscreenControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        self.widthConstraint = fullscreenControllerView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        self.heightConstraint = fullscreenControllerView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true })
        self.view.layoutIfNeeded()
    
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = .init(scaleX: 0, y: 0)
        }, completion: nil)
    }
    
    @objc private func handleRemovedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero
            
            guard let startingFrame = self.cellStartingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = .identity
        }, completion: { _ in
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
        })
    }
}
