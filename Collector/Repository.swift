//
//  Repository.swift
//  Collector
//
//  Created by Dan.Tanner on 10/23/20.
//  Copyright © 2020 cyclometry. All rights reserved.
//

import Foundation
import SQLite

class SensorValRepository {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let db = try Connection("\(path)/db.sqlite3")
    
    let sensor_val = Table("sensor_val")
    
    
    init() {
        // create the tables if they don't already exist
        db.run(sensor_val.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(category)
            t.column(timestamp)
            t.column(value)
        })
        
    }
    
    func insertSensorVal(category: String, timestamp: UInt64, value: UInt8) -> Int64 {
        return try db.run(sensor_val.insert(category <- category, timestamp <- timestamp, value <- value))
    }
    
    func findSensor
}

class RepositoryTest: XCTestCase {
    let repository = SensorValRepository()
    
    func testInsert() {
        let category = "a"
        let timestamp = 16035539943
        let value = "10"
        repository.insertSensorVal(category: category, timestamp: timestamp, value: value)
        
    }
}
