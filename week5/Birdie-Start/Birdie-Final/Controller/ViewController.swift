//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var userPickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }

    func setUpTableView() {
        tableview.dataSource = self
        tableview.separatorColor = .clear
        
        let textCellNib = UINib(nibName: "TextPostTableViewCell", bundle: nil)
        let imageCellNib = UINib(nibName: "ImagePostTableViewCell", bundle: nil)
        
        tableview.register(textCellNib, forCellReuseIdentifier: "textCell")
        tableview.register(imageCellNib, forCellReuseIdentifier: "imageCell")
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 120.0
    }
    
    func setUpImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        
        present(picker, animated: true, completion: nil)
    }
    

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        presentTextPostAlert()
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        setUpImagePicker()
    }
    
    func presentTextPostAlert() {
        let alert = UIAlertController(title: "Create Post", message: "what's up?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Message"
        }
        
        let addAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let name = alert.textFields![0]
            let message = alert.textFields![1]
            
            let textPost = TextPost(textBody: message.text!, userName: name.text!, timestamp: Date())
            
            MediaPostsHandler.shared.addTextPost(textPost: textPost)
            self.tableview.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
            
    }
    
    func presentImagePostAlert() {
        let alert = UIAlertController(title: "Create Post", message: "what's up?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Message"
        }

        let addAction = UIAlertAction(title: "Ok", style: .default) { (action) in

            let name = alert.textFields![0]
            let message = alert.textFields![1]
            if let pickedImage = self.userPickedImage {
                let imagePost = ImagePost(textBody: message.text!, userName: name.text!, timestamp: Date(), image: pickedImage)
                MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
            }

            self.tableview.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in

        }

        alert.addAction(addAction)
        alert.addAction(cancelAction)


        present(alert, animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let cell = MediaPostsViewModel.shared.checkPostTypeCell(for: mediaPost, for: tableView)
        
        return cell

    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        userPickedImage = image
        presentImagePostAlert()
    }
    
}




