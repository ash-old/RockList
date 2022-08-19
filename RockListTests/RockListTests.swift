//
//  RockListTests.swift
//  RockListTests
//
//  Created by Ash Oldham on 19/08/2022.
//

import XCTest
@testable import RockList

class RockListTests: XCTestCase {

  func testMilliToSeconds() {

    let rock = RockListViewModel(view: MainViewController())
    
    let result = rock.dateFormatter(convertDate: "1981-06-03T07:00:00Z")
    XCTAssertEqual(result, "June 1981")
  }

}
