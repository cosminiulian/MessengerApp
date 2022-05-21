//
//  Chat+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 02.03.2022.
//

import MessageKit

extension ChatViewController: DesignProtocol {
    
    func setupNavController() {
        navigationItem.largeTitleDisplayMode = .never
        title = otherUser.fullName
    }
    
    func setupSubviews() { }
    
    func setupConstraints() { }
    
    func setupButtonsMethods() { }
    
}
