//
//  Repository.swift
//  Collector
//
//  Created by Dan.Tanner on 10/23/20.
//  Copyright © 2020 cyclometry. All rights reserved.
//

import Foundation
import SQLite

struct SensorVal {
    var category: String
    var timestamp: Int64
    var value: String
}

enum RepositoryError: Error {
    case notFound
}

func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

class SensorValRepository {
    // /private/var/mobile/Containers/Data/Application/D650987B-5A11-4BE9-BAC0-FC0CB7B84905/Documents/collector-db.sqlite3
    let filePath = "\(getDocumentsDirectory())/collector-db.sqlite3"
    lazy var db = try! Connection(filePath)
    
    let table = Table("sensor_val")
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let timestamp = Expression<Int64>("timestamp")
    let value = Expression<String>("value")
    
    init() {
        // create the tables if they don't already exist
        try! db.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(category)
            t.column(timestamp)
            t.column(value)
        })
        
    }
    
    func insert(sensorVal: SensorVal) -> Int64 {
        return try! db.run(
            table.insert(
                category <- sensorVal.category,
                timestamp <- sensorVal.timestamp,
                value <- sensorVal.value
            )
        )
    }
    
    func get(idArg: Int64) throws -> SensorVal {
        if let row = try db.pluck(table.where(id == idArg)) {
            return SensorVal(
                category: row[category],
                timestamp: row[timestamp],
                value: row[value]
            )
        } else {
            throw RepositoryError.notFound
        }
    }
}


