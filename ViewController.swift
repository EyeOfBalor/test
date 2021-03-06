//
//  ViewController.swift
//  NSURLSession
//
//  Created by Анонимко on 11/12/16.
//  Copyright © 2016 NonameOrg. All rights reserved.
//

import UIKit
import Kanna
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayURL()
        GMSServices.provideAPIKey("AIzaSyBk-sFYrYTJAd_FN2KBeZxYA2fkrVkfUFA")  // API key для использования Google карт
        
        let camera = GMSCameraPosition.camera(withLatitude: 59.926599, longitude:  30.320646, zoom: 13) // Установка камеры над Петербургом
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera) // Инициализация гугл-карт
        view = mapView
        
        var theatreLocations = [CLLocationCoordinate2D]() // Массив позиций кинотеатров
        theatreLocations.append(CLLocationCoordinate2DMake(59.926599, 30.320646)) // Местоположение кинотеатра ПИК
        theatreLocations.append(CLLocationCoordinate2DMake(59.914870, 30.348642)) // Местоположение кинотеатра 2
        theatreLocations.append(CLLocationCoordinate2DMake(59.936259, 30.341750)) // Местоположение кинотеатра 3
        theatreLocations.append(CLLocationCoordinate2DMake(59.879797, 30.265368)) // Местоположение кинотеатра 4
        
        var markers = [GMSMarker]() // Массив маркеров кинотеатров на карте
        for theatrePosition in theatreLocations{ // Заполнение маркеров
            markers.append(GMSMarker(position: theatrePosition))
            markers.last?.map = mapView
        }
        
        markers[0].title = "Кинотеатр ПИК"
    }

    func displayURL(){
        let myURLAdress = "https://www.kinopoisk.ru/film/9028/" // Случайно выбранный фильм
        let myURL = URL(string: myURLAdress)
        let URLTask = URLSession.shared.dataTask(with: myURL!, completionHandler: {
            myData, response, error in
            
            guard error == nil else {return}
            
            let myHTMLString = String(data: myData!, encoding: String.Encoding.windowsCP1251) //
        
            
            if let doc = HTML(html: myHTMLString!, encoding: .windowsCP1251) {
                
                // Search for nodes by XPath
                for link in doc.xpath("//h1[@itemprop='name']") {
                    print(link.text)
                    //print(link["href"])
                }
                for link in doc.xpath("//li[@itemprop='actors']") {
                    print(link.text)
                    //print(link["href"])
                }
                for link in doc.xpath("//div[@itemprop='description']") {
                    print(link.text)
                    //print(link["href"])
                }
                for link in doc.xpath("//div/a/img[@itemprop='image']/@src") {
                    print(link.text)
                    //print(link["href"])
                }
            }
        })
        URLTask.resume()
        
    }
    

}
