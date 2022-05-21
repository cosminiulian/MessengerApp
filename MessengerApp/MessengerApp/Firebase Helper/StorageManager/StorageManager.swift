//
//  StorageManager.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 02.03.2022.
//

import FirebaseStorage

/// Allows to get , fetch, and upload files to Firebase Storage
struct StorageManager {
    
    private let storage = Storage.storage().reference()
    
    static let shared = StorageManager()
    
    private init() { }
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    
    /// Uploads picture to firebase storage and returns completion with url string to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion)  {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            
            guard error == nil else {
                // failed
                print("Failed to upload data to firebase for picture..")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url..")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
            
        })
    }
    
    
    /// Upload image that will be sent in a conversation message
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion)  {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            
            guard error == nil else {
                // failed
                print("Failed to upload data to firebase for picture..")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("message_images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url..")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
            
        })
    }
    
    /// Upload video that will be sent in a conversation message
    public func uploadMessageVideo(with fileUrl: URL, fileName: String, completion: @escaping UploadPictureCompletion)  {
        let storageRef = storage.child("message_videos/\(fileName)")
        let metadata = StorageMetadata()
        //specify MIME type
        metadata.contentType = "video/quicktime"
        
        //convert video url to data
        if let videoData = NSData(contentsOf: fileUrl) as Data? {
            //use 'putData' instead
            storageRef.putData(videoData, metadata: metadata, completion: { metadata, error in
                
                guard error == nil else {
                    // failed
                    print("Failed to upload video file to firebase..")
                    completion(.failure(StorageErrors.failedToUpload))
                    return
                }
                
                self.storage.child("message_videos/\(fileName)").downloadURL(completion: { url, error in
                    guard let url = url else {
                        print("Failed to get download url..")
                        completion(.failure(StorageErrors.failedToGetDownloadUrl))
                        return
                    }
                    
                    let urlString = url.absoluteString
                    print("download url returned: \(urlString)")
                    completion(.success(urlString))
                })
            })
        }
    }
    
    
    public typealias GetPictureUrlCompletion = (Result<URL, Error>) -> Void
    
    /// Get the download url from Firebase Storage
    public func getDownloadURL(for path: String, completion: @escaping GetPictureUrlCompletion) {
        let reference = storage.child(path)
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            
            completion(.success(url))
        })
    }
    
}
