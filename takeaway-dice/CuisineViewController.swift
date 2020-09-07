//
//  CuisineViewController.swift
//  takeaway-dice
//
//  Created by rabei mghrabi on 02/09/2020.
//  Copyright © 2020 rabee mghrabi. All rights reserved.
//

import UIKit
import MapKit

class CuisineViewController: UIViewController {
    @IBOutlet weak var mapview: MKMapView!
    
    var randomName = "Loading..."
    var client_id = "SQMX3LXFEMFOTXZEV3KDA4LIDPCYVDFYLXCRELJU5YHQB5G2"
    var client_secret = "UNF1EN0XFSFXAOTTPOX1AILXMQM13LAK32Z0LGHZE11H21RX"
    let categories = [
        "Japanese": "4bf58dd8d48988d111941735",
        "Indian": "4bf58dd8d48988d10f941735",
        "Lebanese": "58daa1558bbb0b01f18ec1cd",
        "Chinese": "4bf58dd8d48988d145941735",
        "Fastfood": "4bf58dd8d48988d16e941735",
    ]
    
    @IBOutlet weak var cuisinename: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cuisinename.text = randomName
        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 51.504271, longitude: -0.271490)
        mapview.centerToLocation(initialLocation)
        let url = "https://api.foursquare.com/v2/venues/search?categoryId=\(categories[randomName]!)&near=Acton&radius=5000&v=20200901&client_id=\(client_id)&client_secret=\(client_secret)"
        print(url)
        getData(from: url)
        
    }
    
    func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
          var result: Response?
             do {
                let json  = try JSONSerialization.jsonObject(with: data, options:[] )
                print(json)
                let result = try JSONDecoder().decode(Response.self, from: data)
                
                for restaurant in result.response.venues {
                    print(restaurant.name)
                    print(restaurant.location.lat)
                    print(restaurant.location.lng)
                    let annotation = MKPointAnnotation()
                    annotation.title = restaurant.name
                    //You can also add a subtitle that displays under the annotation such as
                    //annotation.subtitle = "One day I'll go here..."
                    annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lng)
                    self.mapview.addAnnotation(annotation)
                    
                }
             }
                
             catch {
                debugPrint(error)
            }
            
            guard result != nil else {
                return
            }
            
            struct Response: Codable {
                var response:R
                
                struct R: Codable{
                    var venues : [Restaurant]
                }
                struct Restaurant: Codable {
                     var name:String
                     var location:Location
                 }
                struct Location: Codable{
                    var lat : Double
                    var lng : Double
                }
                
                
            }
            })
        
            task.resume()
        
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
