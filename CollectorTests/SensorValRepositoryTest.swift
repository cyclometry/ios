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
    let repository = Repository()
    
    func testInsertSensorVal() throws {
        let activityId: Int64 = 1
        let category = "a"
        let elapsedMs: Int64 = 10
        let value = "10"
        let sensorValue = SensorVal(
            activityId: activityId,
            category: category,
            elapsedMs: elapsedMs,
            value: value
        )
        let _ = repository.insertSensorVal(sensorVal: sensorValue)
        
//        let sensorVal = try! repository.get(idArg: id)
//        XCTAssert(sensorVal.category == category)
//        XCTAssert(sensorVal.timestamp == timestamp)
//        XCTAssert(sensorVal.value == value)
    }
}
