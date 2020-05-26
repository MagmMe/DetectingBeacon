//
//  ViewController.swift
//  ConnectingBeacon
//
//  Created by Marcin Magiera on 30/04/2020.
//  Copyright © 2020 Magme Agency. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        view.backgroundColor = .gray
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                }
            }
        }
    }
    
    func startScanning (){
//        let moviBeacon = UUID(uuidString: "4F2F0490-C855-39D3-7BA0-80CFA1590BB0")!
        let uuidiPhone = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5a71096E0")!
        
//        let moviBeacons: [String : String] = [
//            "firstBeacon": "145BAC95-E11E-F77E-3598-55A1DD927BE9",
//            "secondBeacon": "880F9073-3595-8A33-DB4B-B1A55241A780",
//            "thirdBeacon": "4F2F0490-C855-39D3-7BA0-80CFA1590BB0",
//            "fourthBeacon": "BA7D7C63-9530-B42F-5802-36DF21039650",
//            "fifthBeacon": "4C66B8C-09EF-9520-1309-A6F3DA72BBDF",
//            "sixthBeacon": "F75D3F7B-Ac1A-4847-EAFB-6E41B8FD0-FAD",
//            "sevethBeacon": "0004D9CE-2726-3CD4-D1F5-A1160234B597"
//        ] 
        let beaconRegion = CLBeaconRegion(proximityUUID: uuidiPhone, major: 0, minor: 0, identifier: "WellCore")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
          
    }
    
//    Signal Strength
//    immediate -> signal: Strong -> Up to few centimeters
//    near -> signal: Medium -> Up to few meters
//    far -> signal: Weak -> More than a few meters
//    unknown -> signal: extreamly weak impossible to dereminate
    
    func update(distance: CLProximity){
        UIView.animate(withDuration: 1){
            switch distance{
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "Około 1m"
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "Jakieś 50 cm"
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "stoisz przy nim!"
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "NIE WIDZĘ BEACONA"
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first{
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }

}

