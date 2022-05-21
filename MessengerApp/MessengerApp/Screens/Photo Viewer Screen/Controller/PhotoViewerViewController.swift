//
//  PhotoViewerViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import SDWebImage

class PhotoViewerViewController: UIViewController {
    
    private let url: URL
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseIcon"), for: .normal)
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imageView.sd_setImage(with: url)
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        setupGestures()
    }
    
}
