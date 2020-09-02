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
    
    @IBOutlet weak var cuisinename: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let names = ["Japanese", "Indian", "Fastfood", "Chinese","Lebanese"]
        let randomName = names.randomElement()!
        cuisinename.text = randomName
        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapview.centerToLocation(initialLocation)
        
    }
    

    /*
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
