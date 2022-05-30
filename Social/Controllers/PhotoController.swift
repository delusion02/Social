//
//  PhotoController.swift
//  Social
//
//  Created by Сергей Кулагин on 25.06.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoController: UICollectionViewController {
    
    var fullScreenView: UIView?
    var photoArray = [UIImage]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    extension PhotoController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 500, height: 1000)
        }
        
   
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            showView(image: self.photoArray[indexPath.item])
        }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else {return UICollectionViewCell()}
        cell.configure(image: photoArray[indexPath.item])
        return cell
    }
}

extension PhotoController {
    func showView(image: UIImage) {
        if fullScreenView == nil {
        fullScreenView = UIView(frame: self.view.bounds)
        }
        fullScreenView!.backgroundColor = UIColor.systemYellow
        self.view.addSubview(fullScreenView!)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        fullScreenView?.addGestureRecognizer(tapRecognizer)
        let imageView = UIImageView(image: image)
        fullScreenView?.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: fullScreenView!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: fullScreenView!.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive
         = true
        imageView.heightAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive
         = true
        imageView.contentMode = .scaleAspectFill
    
    }
    @objc func onTap() {
        guard let fullScreenView = self.fullScreenView else { return }
        fullScreenView.removeFromSuperview()
    }
}
//extension PhotoController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        showView(image: self.photoArray[indexPath.item])
//    }
//}


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
