//
//  Media.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 11.03.2022.
//

import MessageKit

struct Media: MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
