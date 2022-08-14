//
//  TrackDTO.swift
//  RockList
//
//  Created by Ash Oldham on 03/08/2022.
//

import UIKit

struct TrackDTO: Codable {
  let results: [TrackData]
}

struct TrackData: Codable {
  let trackName: String
  let artistName: String
  let artworkUrl100: String
  let trackPrice: Double
}
