//
//  DetailViewController.swift
//  Project1
//
//  Created by Shilpa Joy on 2021-03-07.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    var selectedImage : String?
    var totalPictures = 0
    var imageIndex = 0
    
    override func viewDidLoad() {
        
        navigationItem.largeTitleDisplayMode = .never
        super.viewDidLoad()
        title = "Picture \(imageIndex) of \(totalPictures)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageLoad = selectedImage {
            detailImage.image = UIImage(named: imageLoad)
        }

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        guard let image = detailImage.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,selectedImage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
