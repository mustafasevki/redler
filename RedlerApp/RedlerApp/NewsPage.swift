//
//  NewsPage.swift
//  RedlerApp
//
//  Created by Mustafa Sevki Cosar on 23.12.2017.
//  Copyright © 2017 Mustafa Sevki Cosar. All rights reserved.
//

import Foundation
import UIKit

class NewsPage:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles:[Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchArticle()
    }
    
    func fetchArticle(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=the-guardian-uk&apiKey=4353ad97869f4a9ab334e3457207c4cb")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                if let articleFromJson = json["articles"] as? [[String: AnyObject]]{
                    for articleFromJson in articleFromJson {
                        let article = Article() //create object from Article class
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.articles?.append(article)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error{
                print(error)
            }
            
        }
        task.resume()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! NewsCell
        
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl)!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }
 
}

extension UIImageView{

func downloadImage(from url: String){
    let urlRequest = URLRequest(url: URL(string: url)!)
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        if error != nil {
            print(error)
            return
        }
        DispatchQueue.main.async {
            self.image = UIImage(data: data!)
        }
    }
    task.resume()
}

}



