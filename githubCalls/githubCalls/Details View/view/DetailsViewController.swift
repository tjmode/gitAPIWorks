//
//  DetailsViewController.swift
//  githubCalls
//
//  Created by Tonywilson Jesuraj on 16/10/21.
//

import UIKit

class DetailsViewController: UIViewController {

    // labels
    @IBOutlet weak var repoNameTitleLabel: UILabel!
    @IBOutlet weak var issueCountLabel: UILabel!
    @IBOutlet weak var repoNameValueLabel: UILabel!
    @IBOutlet weak var detailOneLabel: UILabel!
    @IBOutlet weak var detailTwoLabel: UILabel!
    @IBOutlet weak var detailThreeLabel: UILabel!
    @IBOutlet weak var detailFourLabel: UILabel!
    @IBOutlet weak var detailFiveLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!

    // views
    @IBOutlet weak var styleFiveView: UIView!
    @IBOutlet weak var styleFourView: UIView!
    @IBOutlet weak var styleThreeView: UIView!
    @IBOutlet weak var styleTwoView: UIView!
    @IBOutlet weak var styleOneView: UIView!
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var issueView: UIView!
    @IBOutlet weak var issueCountView: UIView!
    var viewModel = DetailsViewModel()
    var data = repoModel() {
        didSet {
            viewModel.repoData = data
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
    }
    func viewSetUp() {
        styleFiveView.viewDesign()
        styleFourView.viewDesign()
        styleThreeView.viewDesign()
        styleTwoView.viewDesign()
        styleOneView.viewDesign()
        urlView.viewDesign()
        issueView.viewDesign()
        issueCountView.viewDesign()
        
        // Label
        issueCountLabel.text = viewModel.repoData.openIssues == "" ? "0": viewModel.repoData.openIssues
        repoNameValueLabel.text = viewModel.repoData.name
        urlLabel.text = viewModel.repoData.cloneUrl
        detailOneLabel.text = "language used: \(viewModel.repoData.language)"
        detailTwoLabel.text = "default Branch: \(viewModel.repoData.defaultBranch)"
        detailThreeLabel.text = "visibility: \(viewModel.repoData.visibility)"
        detailFourLabel.text = "watchersCount: \(viewModel.repoData.watchersCount == "" ? "0": viewModel.repoData.watchersCount)"
        detailFiveLabel.text = "details: \(viewModel.repoData.details  == "" ? "No details": viewModel.repoData.details)"
    }
}

extension UIView {
    func viewDesign() {
        self.layer.cornerRadius = 10.0
    }
}
