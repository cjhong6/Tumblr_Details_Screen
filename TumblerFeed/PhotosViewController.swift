//
//  PhotosViewController.swift
//  TumblerFeed
//
//  Created by Chengjiu Hong on 9/4/18.
//  Copyright © 2018 Chengjiu Hong. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts: [[String:Any]] = []
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMovie()
    

    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchMovie()
        
    }
    
    func fetchMovie(){
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                // TODO: Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String:Any]
                self.posts = responseDictionary["posts"] as! [[String:Any]]
                // TODO: Reload the table view
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = self.posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String:Any]]{
            let photo = photos[0]
            let orignalSize = photo["original_size"] as? [String:Any]
            let urlString = orignalSize?["url"] as! String
            let url = URL(string: urlString)
            
            cell.posterImage.af_setImage(withURL: url!)
        
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
