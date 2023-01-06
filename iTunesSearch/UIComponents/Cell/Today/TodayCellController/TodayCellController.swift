//
//  TodayCellController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 5.01.2023.
//

import UIKit

final class TodayCellController: UITableViewController {
    
    internal var dismissHandler: (() -> ())?
    internal var appGroup: [FeedResult] = []
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TodayFullscreenCell.self, forCellReuseIdentifier: TodayFullscreenCell.identifier)
    }
    
// MARK: - UITableView Delegate & Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = TodayFullscreenHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            return headerCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayFullscreenCell.identifier, for: indexPath) as! TodayFullscreenCell
            cell.design(appGroup: self.appGroup[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 128
        } else {
            return 72
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = appGroup[indexPath.row]
        present(AppDetailBuilder.start(id: app.id), animated: true)
    }
}

// MARK: - HandleDismiss
extension TodayCellController {
    @objc private func handleDismiss(_ button: UIButton) {
        button.isHidden = true
        self.dismissHandler?()
    }
}
