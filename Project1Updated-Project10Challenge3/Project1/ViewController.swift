//
//  ViewController.swift
//  Project1
//
//  Created by Nathan Segura on 2/21/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadImages), with: nil)
    }
    
    @objc func loadImages() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        collectionView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue 'PictureCell'.")
        }
        
        cell.name.text = pictures[indexPath.item]
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 7
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let image = pictures[indexPath.item]
            viewController.selectedImage = image
            viewController.totalImages = pictures.count
            viewController.selectedImageIndex = pictures.firstIndex(of: image)! + 1
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
