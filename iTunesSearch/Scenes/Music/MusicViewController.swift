//
//  MusicViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import UIKit

protocol MusicViewProtocol: AnyObject {
    func prepareCollectionView()
    func prepareActivityIndicatorView()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showTracks(tracks: [ResultModel])
}

final class MusicViewController: UIViewController {
    
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
    
    private var tracks: [ResultModel] = []
    private var isPaginating = false
    
    internal var presenter: MusicPresenterProtocol!
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - View Protocol
extension MusicViewController: MusicViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: view.topAnchor,
                              leading: view.leftAnchor, trailing: view.rightAnchor,
                              bottom: view.bottomAnchor)
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: TrackCell.identifier)
        collectionView.register(MusicLoadingFooter.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: MusicLoadingFooter.identifier)
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
    
    func showTracks(tracks: [ResultModel]) {
        self.tracks = tracks
    }
}

// MARK: - UICollectionView Delegate & Data source
extension MusicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.identifier, for: indexPath) as? TrackCell else { return UICollectionViewCell() }
        cell.design(track: self.tracks[indexPath.item])
        
// MARK: Pagination
        if indexPath.item == self.tracks.count - 1, !self.isPaginating {
            self.isPaginating = true
            presenter.loadMoreMusic()
            self.isPaginating = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MusicLoadingFooter.identifier, for: indexPath) as? MusicLoadingFooter else { return UICollectionViewCell() }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
