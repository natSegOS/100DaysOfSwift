//
//  DetailViewController.swift
//  Project1
//
//  Created by Nathan Segura on 2/22/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var totalImages: Int?
    var selectedImageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageIndex = selectedImageIndex, let totalImages = totalImages {
            title = "Picture \(imageIndex) of \(totalImages)"
        } else {
            title = selectedImage
        }
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found.")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true)
    }
}
