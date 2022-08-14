//
//  RockListViewModel.swift
//  RockList
//
//  Created by Ash Oldham on 02/08/2022.
//

import Foundation
import UIKit

protocol RockListView: AnyObject {
  func update()
}

class RockListViewModel {
  
  let url = "https://itunes.apple.com/search?term=rock"
  var view: RockListView?
  var currentIndex: Int = 0
  var track: [TrackData]?
  
  init(view: RockListView) {
    self.view = view
    
    getTrackData()
  }
  
  func getTrackData() {
    let group = DispatchGroup()
    let urlString = "\(url)"
    //1. create a URL
    let urls = [ URL(string: urlString) ]
    //2. create a URLSession
    let session = URLSession(configuration: .default)
    //3. give the session a task
    for url in urls {
      group.enter()
      
      let task = session.dataTask(with: url!) { (data, response, error) in
        if error != nil {
          print("Error", error!)
          group.leave()
          group.notify(queue: DispatchQueue.main, execute: {
            print("All Done");
          })
          return
        }
        if let safeData = data {
          let rockList = self.parseJSON(safeData)
        }
      }
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(TrackDTO.self, from: data)
//      let track = decodedData.results[currentIndex].trackName
//      let artist = decodedData.results[currentIndex].artistName
//      let price = decodedData.results[currentIndex].trackPrice
//      let image = decodedData.results[currentIndex].artworkUrl30
      
//      model = [TrackModel(trackName: track, artist: artist, price: price, image: image)]
      track = decodedData.results
//      print("AAAA", track)
      decodedData.results.forEach({ song in
        print("SONG", song)
      })
//      return model
      
    } catch {
      print(error)
//      return nil
    }
  }

}
