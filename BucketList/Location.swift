//
//  Location.swift
//  BucketList
//
//  Created by Ken Muyesu on 20/02/2022.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    var longitude: Double
    
    //computed property
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //static example property
    static let example = Location(id: UUID(), name: "Nairobi Arboretum", description: "Best picnic site in the heart of the city", latitude: 1.16, longitude: 36.48)
    
    //comparing two identifiers
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
