//
//  DetailViewController.swift
//  Project1
//
//  Created by Barkha Maheshwari on 15/05/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    var selectedImage: String?
    var imageCount: Int?
    var selectedImageCount: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let count1 = selectedImageCount, let totalCount = imageCount {
            title = "Picture \(count1 + 1) of \(totalCount)"
        }
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped)
        )
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    @objc func shareTapped() {
        guard let imageToShare = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Got nothing to share.")
            return
        }
        let vc = UIActivityViewController(
            activityItems: [imageToShare, selectedImage],
            applicationActivities: []
        )
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
