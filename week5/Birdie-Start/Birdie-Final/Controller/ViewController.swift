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

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }

    func setUpTableView() {
        tableview.dataSource = self
        
        let textCellNib = UINib(nibName: "TextPostTableViewCell", bundle: nil)
        let imageCellNib = UINib(nibName: "ImagePostTableViewCell", bundle: nil)
        
        tableview.register(textCellNib, forCellReuseIdentifier: "textCell")
        tableview.register(imageCellNib, forCellReuseIdentifier: "imageCell")
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 120.0
    }
    
    

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

        let alert = UIAlertController(title: "Create Post", message: "what's up?", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
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

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let postDateFormatter = DateFormatter()
        postDateFormatter.dateFormat = "dd MMM, HH:mm:ss"
        
        switch mediaPost {

        case let textPost as TextPost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextPostTableViewCell
            cell.nameLabel.text = textPost.userName
            cell.dateLabel.text = postDateFormatter.string(from: textPost.timestamp)
            cell.messageLabel.text = textPost.textBody
            return cell

        case let imagePost as ImagePost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImagePostTableViewCell
            cell.nameLabel.text = imagePost.userName
            cell.dateLabel.text = postDateFormatter.string(from: imagePost.timestamp)
            cell.messageLabel.text = imagePost.textBody
            cell.messageImage.image = imagePost.image
            return cell

        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = mediaPost.textBody
            return cell
        }
    }

}




