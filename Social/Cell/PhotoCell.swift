//
//  PhotoCell.swift
//  Social
//
//  Created by Сергей Кулагин on 25.06.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var numberOfLikes = 0
    var like = false
    
    
    func setup() {
    }
    
    func clearCell() {
        photoImageView.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    
    func viewDidLoad() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        setup()
    }
    
    func animateTitle() {
        likeLabel.transform = CGAffineTransform(translationX: 0 , y: 500)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .transitionFlipFromTop, animations: { self.likeLabel.transform = .identity }, completion: nil)
    }

    @IBAction func pressLike(_ sender: UIButton) {
        if like {
            heartImage.image = UIImage(systemName: "heart")
            numberOfLikes -= 1
            animateTitle()
        }
        else {
            heartImage.image = UIImage(systemName: "heart.fill")
            numberOfLikes += 1
            animateTitle()
        }
        likeLabel.text = String(numberOfLikes)
        like = !like
        }
    }


