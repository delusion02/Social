//
//  UniversalTableCell.swift
//  Social
//
//  Created by Сергей Кулагин on 25.06.2021.
//

import UIKit

class UniversalTableCell: UITableViewCell {
    
    @IBOutlet weak var imgeView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var savedObject: Any?
    
    func setup() {
        imgeView?.layer.cornerRadius = 25
        backView.layer.cornerRadius = 25
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 5, height: 5)
        backView.layer.shadowRadius = 4
        backView.layer.shadowOpacity = 0.5
    }
    
    func clearCell() {
        self.imgeView?.image = nil
        self.titleLabel.text = nil
        savedObject = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    func configure(title: String?, image: UIImage?) {
        titleLabel.text = title
        imgeView?.image = image
    }
    func configure(friends: Friends) {
        savedObject = friends
        titleLabel.text = friends.name
        imgeView?.image = friends.avatar
        descriptionLabel.text = friends.description
    }
    func configure(group: Group) {
        savedObject = group
        titleLabel.text = group.title
        imgeView?.image = group.avatar
        descriptionLabel.text = group.description
    }

    @IBAction func photoAnimation(_ sender: Any) {
            let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
            animation.repeatCount = 3
            animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: imgeView.center.x - 8, y: imgeView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: imgeView.center.x + 8, y: imgeView.center.y))
        imgeView.layer.add(animation, forKey: "position")
        animation.fromValue = NSValue(cgPoint: CGPoint(x: backView.center.x - 8, y: backView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: backView.center.x + 8, y: backView.center.y))
        backView.layer.add(animation, forKey: "position")
    
        }
    

}
