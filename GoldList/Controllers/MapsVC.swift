//
//  MapsVC.swift
//  GoldList
//
//  Created by Brian Gomes on 17/11/2020.
//

import UIKit
import GoogleMaps

class MapsVC: UIViewController {

    let locationManager = CLLocationManager()
    var selectedCategory = 1
    let dataProvider = GoogleDataProvider()
    private var searchedFoodTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    private var searchedShopTypes = ["supermarket","electronics_store"]
    
    private var searchedActivities = ["library","museum","aquarium"]
    
    
    private let searchRadius: Double = 5000

    @IBOutlet weak var mapview: GMSMapView!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        locationManager.delegate = self
        mapview.delegate = self

          // 2
          if CLLocationManager.locationServicesEnabled() {
            // 3
            locationManager.requestLocation()

            // 4
            mapview.isMyLocationEnabled = true
            mapview.settings.myLocationButton = true
            
          //  fetchPlaces(near: mapView.camera.target)
          } else {
            // 5
            locationManager.requestWhenInUseAuthorization()
          }
    }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
      // 1
      let geocoder = GMSGeocoder()

      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard
          let address = response?.firstResult(),
          let lines = address.lines
          else {
            return
        }

        // 3
      //  self.addressLbl.text = lines.joined(separator: "\n")

        // 4
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }


    func fetchPlaces(near coordinate: CLLocationCoordinate2D){
      // 1
      mapview.clear()
      // 2
        
        if selectedCategory == 1{
            dataProvider.fetchPlaces(
              near: coordinate,
              radius:searchRadius,
              types: searchedActivities
            ) { places in
              places.forEach { place in
                // 3
                let marker = PlaceMarker(place: place, availableTypes: self.searchedActivities)
                // 4
                marker.map = self.mapview
              }
            }
        }else if selectedCategory == 2{
            dataProvider.fetchPlaces(
              near: coordinate,
              radius:searchRadius,
              types: searchedFoodTypes
            ) { places in
              places.forEach { place in
                // 3
                let marker = PlaceMarker(place: place, availableTypes: self.searchedFoodTypes)
                // 4
                marker.map = self.mapview
              }
            }
        }else if selectedCategory == 3{
            dataProvider.fetchPlaces(
              near: coordinate,
              radius:searchRadius,
              types: searchedShopTypes
            ) { places in
              places.forEach { place in
                // 3
                let marker = PlaceMarker(place: place, availableTypes: self.searchedShopTypes)
                // 4
                marker.map = self.mapview
              }
            }
        }
        
     
    }
    
    
    @IBAction func filterClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        fetchPlaces(near: mapview.camera.target)

    }
    
    
    
}


// MARK: - MAPS & LOCATION
//1
extension MapsVC: CLLocationManagerDelegate {
  // 2
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    
    
    locationManager.requestLocation()
    mapview.isMyLocationEnabled = true
    mapview.settings.myLocationButton = true
    
  }
    
    // 6
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            
            return
        }

    
    
    // 7
    mapview.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
    fetchPlaces(near: location.coordinate)
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}

// MARK: - GMSMapViewDelegate
extension MapsVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocode(coordinate: position.target)
    }
    
    func mapView(
      _ mapView: GMSMapView,
      markerInfoContents marker: GMSMarker
    ) -> UIView? {
      // 1
      guard let placeMarker = marker as? PlaceMarker else {
        return nil
      }

      // 2
      guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView
        else {
          return nil
      }

      // 3
      infoView.nameLabel.text = placeMarker.place.name
      infoView.addressLabel.text = placeMarker.place.address

      return infoView
    }
}
