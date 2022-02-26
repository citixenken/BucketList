//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Ken Muyesu on 24/02/2022.
//

import Foundation
import MapKit
import LocalAuthentication

class ViewModel: ObservableObject {
    
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isUnlocked = false
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.22, longitude: 6.08), span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else {
                return
            }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places." // For TouchID
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        Task { @MainActor in
                                self.isUnlocked = true
                            
                        }
                    } else {
                        //error
                    }
                }
            } else {
                //no biometrics
            }
        }
    }
}
