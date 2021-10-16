//
//  ViewController.swift
//  githubCalls
//
//  Created by Tonywilson Jesuraj on 14/10/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var noDataLabel: UILabel? {
        didSet {
            noDataLabel?.isHidden = true
        }
    }
    @IBOutlet weak var repoTableView: UITableView? {
        didSet {
            repoTableView?.delegate = self
            repoTableView?.dataSource = self
            repoTableView?.register(UINib(nibName: "RepoDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoDetailsTableViewCell")
        }
    }
    var viewModel = RepoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("dataLoaded"), object: nil)
        if !viewModel.isDataAvailable() {
            noDataLabel?.isHidden = false
        }
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        viewModel.load(data: notification.object as! [repoModel])
        if viewModel.isDataAvailable() {
            DispatchQueue.main.async {
                self.repoTableView?.reloadData()
            }
        } else {
            noDataLabel?.isHidden = false
        }
    }

    func moveToDetails(with index: Int) {
        let detailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        detailsViewController.data = viewModel.repoData[index]
        self.present(detailsViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoDetailsTableViewCell", for: indexPath) as! RepoDetailsTableViewCell
        if viewModel.isDataAvailable() {
            cell.selectionStyle = .none
            cell.config(data: viewModel.repoData[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToDetails(with: indexPath.row)
    }
}
