//
//  Chat+ActionSheet.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 15.03.2022.
//

import UIKit
import CoreLocation

extension ChatViewController {
    
    func presentInputActionSheet() {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        // Photo Alert Action
        let photoAlertAction = UIAlertAction(title: "Photo",
                                             style: .default,
                                             handler: { [weak self] _ in
            self?.presentPhotoInputActionSheet()
        })
        photoAlertAction.setValue(UIImage(systemName: "photo"), forKey: "image")
        photoAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(photoAlertAction)
        
        // Video Alert Action
        let videoAlertAction = UIAlertAction(title: "Video",
                                             style: .default,
                                             handler: { [weak self] _ in
            self?.presentVideoInputActionSheet()
        })
        videoAlertAction.setValue(UIImage(systemName: "video"), forKey: "image")
        videoAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(videoAlertAction)
        
        // Location Alert Action
        let locationAlertAction = UIAlertAction(title: "Location",
                                                style: .default,
                                                handler: { [weak self] _ in
            self?.presentLocationPicker()
        })
        locationAlertAction.setValue(UIImage(systemName: "location"), forKey: "image")
        locationAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(locationAlertAction)
        
        // Cancel Alert Action
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func presentPhotoInputActionSheet() {
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "Where would you like to attach a photo from?",
                                            preferredStyle: .actionSheet)
        
        // Camera Alert Action
        let cameraAlertAction = UIAlertAction(title: "Camera",
                                              style: .default,
                                              handler: { [weak self] _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self?.present(imagePicker, animated: true)
        })
        cameraAlertAction.setValue(UIImage(systemName: "camera"), forKey: "image")
        cameraAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(cameraAlertAction)
        
        // Library Alert Action
        let libraryAlertAction = UIAlertAction(title: "Library",
                                               style: .default,
                                               handler: { [weak self] _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self?.present(imagePicker, animated: true)
        })
        libraryAlertAction.setValue(UIImage(systemName: "photo.on.rectangle.angled"), forKey: "image")
        libraryAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(libraryAlertAction)
        
        // Cancel Alert Action
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func presentVideoInputActionSheet() {
        let actionSheet = UIAlertController(title: "Attach Video",
                                            message: "Where would you like to attach a video from?",
                                            preferredStyle: .actionSheet)
        
        // Camera Alert Action
        let cameraAlertAction = UIAlertAction(title: "Camera",
                                              style: .default,
                                              handler: { [weak self] _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.mediaTypes = ["public.movie"]
            imagePicker.videoQuality = .typeMedium
            imagePicker.allowsEditing = true
            self?.present(imagePicker, animated: true)
        })
        cameraAlertAction.setValue(UIImage(systemName: "camera"), forKey: "image")
        cameraAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(cameraAlertAction)
        
        // Library Alert Action
        let libraryAlertAction = UIAlertAction(title: "Library",
                                               style: .default,
                                               handler: { [weak self] _ in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.mediaTypes = ["public.movie"]
            imagePicker.videoQuality = .typeMedium
            imagePicker.allowsEditing = true
            self?.present(imagePicker, animated: true)
        })
        libraryAlertAction.setValue(UIImage(systemName: "photo.on.rectangle.angled"), forKey: "image")
        libraryAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        actionSheet.addAction(libraryAlertAction)
        
        // Cancel Alert Action
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func presentLocationPicker() {
        let locationPickerVC = LocationPickerViewController()
        locationPickerVC.completion = { [weak self] selectedCoordinates in
            
            let longitude: Double = selectedCoordinates.longitude
            let latitude: Double = selectedCoordinates.latitude
            
            Constants.isActiveNotification = false
            guard let self = self else {
                return
            }
            
            guard let conversationId = self.conversationId,
                  let sender = self.sender,
                  let messageId = self.createMessageId() else {
                return
            }
            
            let location = Location(location: CLLocation(latitude: latitude, longitude: longitude),
                                    size: .zero)
            
            let message = Message(sender: sender,
                                  messageId: messageId,
                                  sentDate: Date(),
                                  kind: .location(location))
            // Send Image Message
            DatabaseManager.shared.sendMessage(conversationId: conversationId,
                                               otherUser: self.otherUser,
                                               newMessage: message,
                                               completion: { success in
                if !success {
                    self.displayAlert(message: "Failed to send location message..")
                }
            })
        }
        navigationController?.pushViewController(locationPickerVC, animated: true)
    }
    
}
