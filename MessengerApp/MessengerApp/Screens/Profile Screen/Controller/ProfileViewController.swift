//
//  ProfileViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import JGProgressHUD

class ProfileViewController: UIViewController {
    
    var profileImageWasChanged: Bool = false
    
    let spinner = JGProgressHUD(style: .dark)
    
    let profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.backgroundColor = .secondarySystemBackground
        return profileHeaderView
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Details"
        return label
    }()
    
    let fullNameStackView: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Full name:"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let fullNameContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let emailStackView: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "Email address:"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let emailContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        setupString()
    }
    
}
