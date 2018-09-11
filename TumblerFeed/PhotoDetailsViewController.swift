//
//  PhotoDetailsViewController.swift
//  TumblerFeed
//
//  Created by Chengjiu Hong on 9/10/18.
//  Copyright © 2018 Chengjiu Hong. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    var post:[String : Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if let photos = post["photos"] as? [[String:Any]]{
                let photo = photos[0]
                let orignalSize = photo["original_size"] as? [String:Any]
                let urlString = orignalSize?["url"] as! String
                let url = URL(string: urlString)
                posterImage.af_setImage(withURL: url!)
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
