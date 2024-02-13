//
//  Recording.swift
//
//  Created by Chris Ubick 12/13/2023
//

import Foundation

struct Recording : Identifiable {
    var id: String {
        self.fileURL.absoluteString
    }
    var fileURL : URL
    let createdAt : Date
    var name : String = ""
    var isPlaying : Bool
}
