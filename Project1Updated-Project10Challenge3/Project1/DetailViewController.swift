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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
