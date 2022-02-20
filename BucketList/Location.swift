//
//  Location.swift
//  BucketList
//
//  Created by Ken Muyesu on 20/02/2022.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    var longitude: Double
}
