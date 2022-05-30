//
//  NewsCell.swift
//  Social
//
//  Created by Сергей Кулагин on 23.08.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var repostImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var savedObject: Any?
    var newsLike = false
    var numberOfLikes = 0
    
    
    func setup() {
         
    }
    
    func configures(news: News) {
        newsTextLabel.text = news.name
        newsImage?.image = news.image
        descriptionLabel.text = news.description
    }
    
    func clearCell() {
        savedObject = nil
        newsImage.image = nil
        newsTextLabel.text = nil
        
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
    func configure() {
        likeLabel.text = String(numberOfLikes)
    }
    
    func animateTitle() {
        likeLabel.transform = CGAffineTransform(translationX: 0 , y: 500)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .transitionFlipFromTop, animations: { self.likeLabel.transform = .identity }, completion: nil)
    }
    
    @IBAction func newsLikeButton(_ sender: Any) {
        configure()
        if newsLike {
            likeImage.image = UIImage(systemName: "heart")
            numberOfLikes -= 1
            animateTitle()
        }
        else {
            likeImage.image = UIImage(systemName: "heart.fill")
            numberOfLikes += 1
            animateTitle()
        }
        likeLabel.text = String(numberOfLikes)
        newsLike = !newsLike
    }
    @IBAction func newsRepostButton(_ sender: Any) {
        
    }
}
