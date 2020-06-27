//
//  MediaPostsViewModel.swift
//  Birdie-Final
//
//  Created by Donald Seo on 2020-06-27.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit


class MediaPostsViewModel {
    
    static let shared = MediaPostsViewModel()
    
    func checkPostTypeCell(for post: MediaPost, for tableview: UITableView) -> UITableViewCell {
        
        let postDateFormatter = DateFormatter()
        postDateFormatter.dateFormat = "dd MMM, HH:mm:ss"
        
        switch post {

        case let textPost as TextPost:
            let cell = tableview.dequeueReusableCell(withIdentifier: "textCell") as! TextPostTableViewCell
            cell.nameLabel.text = textPost.userName
            cell.dateLabel.text = postDateFormatter.string(from: textPost.timestamp)
            cell.messageLabel.text = textPost.textBody
            return cell

        case let imagePost as ImagePost:
            let cell = tableview.dequeueReusableCell(withIdentifier: "imageCell") as! ImagePostTableViewCell
            cell.nameLabel.text = imagePost.userName
            cell.dateLabel.text = postDateFormatter.string(from: imagePost.timestamp)
            cell.messageLabel.text = imagePost.textBody
            cell.messageImage.image = imagePost.image
            return cell

        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = post.textBody
            return cell
        }
    }
}
