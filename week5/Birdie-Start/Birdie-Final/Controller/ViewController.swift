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
        self.tableview.dataSource = self
        
        let textCellNib = UINib(nibName: "TextPostTableViewCell", bundle: nil)
        let imageCellNib = UINib(nibName: "ImagePostTableViewCell", bundle: nil)
        
        self.tableview.register(textCellNib, forCellReuseIdentifier: "textCell")
        self.tableview.register(imageCellNib, forCellReuseIdentifier: "imageCell")
    }
    
    

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

        let alert = UIAlertController(title: "Create Post", message: "", preferredStyle: .alert)
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
        
//        if let mediaPost = mediaPost as? TextPost {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextPostTableViewCell
//            cell.nameLabel.text = mediaPost.userName
//            cell.dateLabel.text = "mediaPost.timestamp"
//            cell.messageLabel.text = mediaPost.textBody
//            return cell
//        } else {
//            let cell = UITableViewCell()
//            cell.textLabel?.text = mediaPost.textBody
//            return cell
//        }
        
        switch mediaPost {

        case let textPost as TextPost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextPostTableViewCell
            cell.nameLabel.text = textPost.userName
            cell.dateLabel.text = "textPost.timestamp"
            cell.messageLabel.text = textPost.textBody
            return cell

        case let imagePost as ImagePost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImagePostTableViewCell
            cell.nameLabel.text = imagePost.userName
            cell.dateLabel.text = "imagePost.timestamp"
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




