//
//  Astronauts.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import Foundation

struct Astronauts: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [Astronaut]
}

struct Astronaut: Codable {
    let id: Int
    let name: String
    let nationality: String
    let profile_image_thumbnail: String
}
