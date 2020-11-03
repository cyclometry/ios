import Foundation
import SQLite

struct Activity {
    var id: Int64
    var name: String
    var startTime: Int
}

struct SensorVal {
    var activityId: Int64
    var category: String
    var elapsedMs: Int64
    var value: String
}

enum RepositoryError: Error {
    case notFound
}

func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

class Repository {
    // /private/var/mobile/Containers/Data/Application/D650987B-5A11-4BE9-BAC0-FC0CB7B84905/Documents/collector-db.sqlite3
    let filePath = "\(getDocumentsDirectory())/collector-db.sqlite3"
    lazy var db = try! Connection(filePath)
    
    let activityTable = Table("activity")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let startTime = Expression<Int64>("start_time")
    
    let sensorValTable = Table("sensor_val")
    let activityId = Expression<Int64>("activity_id")
    let category = Expression<String>("category")
    let elapsedMs = Expression<Int64>("elapsed_ms")
    let value = Expression<String>("value")
    
    
    init() {
        // create the tables if they don't already exist
        try! db.run(activityTable.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(name)
            t.column(startTime)
        })
        
        try! db.run(sensorValTable.create(ifNotExists: true) { t in
            t.column(activityId)
            t.column(category)
            t.column(elapsedMs)
            t.column(value)
        })
    }
    
    func insertSensorVal(sensorVal: SensorVal) -> Int64 {
        return try! db.run(
            sensorValTable.insert(
                activityId <- sensorVal.activityId,
                category <- sensorVal.category,
                elapsedMs <- sensorVal.elapsedMs,
                value <- sensorVal.value
            )
        )
    }
}
