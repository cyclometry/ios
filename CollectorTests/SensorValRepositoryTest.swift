//
//  CollectorTests.swift
//  CollectorTests
//
//  Created by Dan.Tanner on 10/24/20.
//  Copyright © 2020 cyclometry. All rights reserved.
//

import XCTest
import Collector

@testable import Collector

class SensorValRepositoryTest: XCTestCase {
    let repository = SensorValRepository()
    
    func testInsertAndFindById() throws {
        let category = "a"
        let timestamp: Int64 = 16035539943
        let value = "10"
        let sensorValue = SensorVal(
            category: category,
            timestamp: timestamp,
            value: value
        )
        let id = repository.insert(sensorVal: sensorValue)
        
        let sensorVal = try! repository.get(idArg: id)
        XCTAssert(sensorVal.category == category)
        XCTAssert(sensorVal.timestamp == timestamp)
        XCTAssert(sensorVal.value == value)
    }
}
