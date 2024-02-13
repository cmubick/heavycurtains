//
//  Song.swift
//  heavycurtains
//
//  Created by Chris Ubick on 11/23/23.
//

import Foundation
import SwiftUI

struct Song: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
