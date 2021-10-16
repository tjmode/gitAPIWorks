//
//  RepoDetailsTableViewCell.swift
//  githubCalls
//
//  Created by Tonywilson Jesuraj on 14/10/21.
//

import UIKit

class RepoDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var githubRepoImage: UIImageView? {
        didSet {
            githubRepoImage?.layer.borderWidth = 1
            githubRepoImage?.layer.masksToBounds = false
            githubRepoImage?.layer.borderColor = UIColor.black.cgColor
            githubRepoImage?.layer.cornerRadius = (githubRepoImage?.frame.height ?? 75)/2
            githubRepoImage?.clipsToBounds = true
        }
    }
    var colorCode = ["#92e8a9", "#e0e38f", "#cf8adb", "#e691aa"]
    @IBOutlet weak var cardView: UIView? {
        didSet {
            cardView?.layer.cornerRadius = 10.0
            cardView?.backgroundColor = hexStringToUIColor(hex: colorCode.randomElement() ?? "")
        }
    }
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    func config(data: repoModel) {
        repoNameLabel.text = data.name
        if data.details == "" {
            descriptionLabel.text = "No Description"
        } else {
            descriptionLabel.text = data.details
        }
        displayImageWith(stringUrl: data.avatarUrl)
    }
    func displayImageWith(stringUrl: String) {
        let url = URL(string: stringUrl)
        let data = try? Data(contentsOf:url!)
        if let imageData = data {
            githubRepoImage?.image = UIImage(data: imageData)
        }
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
