//
//  ViewController.swift
//  NSURLSession
//
//  Created by Анонимко on 11/12/16.
//  Copyright © 2016 NonameOrg. All rights reserved.
//

import UIKit
import Kanna

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayURL()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func displayURL(){
        let myURLAdress = "https://www.kinopoisk.ru/film/9028/"
        let myURL = URL(string: myURLAdress)
        let URLTask = URLSession.shared.dataTask(with: myURL!, completionHandler: {
            myData, response, error in
            
            guard error == nil else {return}
            
            let myHTMLString = String(data: myData!, encoding: String.Encoding.windowsCP1251)
            
       //     self.myWebView.loadHTMLString(myHTMLString!, baseURL: nil)
            
            
            
            if let doc = HTML(html: myHTMLString!, encoding: .windowsCP1251) {
                // print(doc.title)
                
                // Search for nodes by CSS
//                for link in doc.css("a, link") {
//                    print(link.text)
//                    print(link["href"])
//                }
                
                // Search for nodes by XPath
                for link in doc.xpath("//h1[@itemprop='name']") {  // Вывод названия фильма
                    print(link.text)
                }
                for link in doc.xpath("//li[@itemprop='actors']") { // Вывод актеров
                    print(link.text)
                }
                for link in doc.xpath("//div[@itemprop='description']") { // Вывод описания фильма
                    print(link.text)
                }
                for link in doc.xpath("//div/a/img[@itemprop='image']/@src") { // Вывод ссылки на изображение фильма
                    print(link.text)
                }
            }
        })
        URLTask.resume()
        
    }
    

}

