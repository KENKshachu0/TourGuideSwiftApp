//
//  File.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//
import Foundation
import SQLite3

//account
struct Credentials {
    var username: String
    var password: String
}

struct ScenicSpot: Identifiable {
    var id: Int
    var title: String
    var description: String
    var imageUrl: String
    var longitude: Double
    var latitude: Double
}


class DatabaseManager {
    var db: OpaquePointer?

    init() {
        openDatabase()
        createTable()
    }

    func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ScenicSpots.sqlite")

        let openResult = sqlite3_open(fileURL.path, &db)
        if openResult != SQLITE_OK {
            print("error opening database")
            print("SQLite error code: \(openResult)")
            if let errmsg = sqlite3_errmsg(db) {
                print("SQLite error message: \(String(cString: errmsg))")
            }
        } else {
            print("Database opened successfully")
        }
    }

    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS ScenicSpots(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Title CHAR(255),
        Description TEXT,
        ImageUrl CHAR(255),
        Longitude REAL,
        Latitude REAL);
        """

        if sqlite3_exec(db, createTableString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertScenicSpot(spot: ScenicSpot) {
        let insertStatementString = "INSERT INTO ScenicSpots (Title, Description, ImageUrl, Longitude, Latitude) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil

        print("Insert statement string: \(insertStatementString)")

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (spot.title + "\0" as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (spot.description + "\0" as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (spot.imageUrl + "\0" as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 4, spot.longitude)
            sqlite3_bind_double(insertStatement, 5, spot.latitude)

            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("error inserting row")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert statement: \(errmsg)")
        }
    }


    
    func queryScenicSpots() -> [ScenicSpot] {
        let queryStatementString = "SELECT * FROM ScenicSpots;"
        var queryStatement: OpaquePointer? = nil
        var spots: [ScenicSpot] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let title = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let imageUrl = String(cString: sqlite3_column_text(queryStatement, 3))
                let longitude = sqlite3_column_double(queryStatement, 4)
                let latitude = sqlite3_column_double(queryStatement, 5)

                spots.append(ScenicSpot(id: id, title: title, description: description, imageUrl: imageUrl, longitude: longitude, latitude: latitude))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return spots
    }
    
    func fetchAllScenicSpots() -> [ScenicSpot] {
        let queryStatementString = "SELECT * FROM ScenicSpots;"
        var queryStatement: OpaquePointer? = nil
        var spots: [ScenicSpot] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let title = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let imageUrl = String(cString: sqlite3_column_text(queryStatement, 3))
                let longitude = sqlite3_column_double(queryStatement, 4)
                let latitude = sqlite3_column_double(queryStatement, 5)

                spots.append(ScenicSpot(id: id, title: title, description: description, imageUrl: imageUrl, longitude: longitude, latitude: latitude))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return spots
    }
    
    func deleteScenicSpot(byId id: Int) {
        let deleteStatementString = "DELETE FROM ScenicSpots WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted spot")
            } else {
                print("delete spot failed")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
}

//数据库文件保存路径为：/Users/kenk/Library/Developer/CoreSimulator/Devices/4D4E4B1E-7F6F-4E7F-8A3E-0D6F6A7B4E3B/data/Containers/Data/Application/1A3C4C6D-6F7F-4E7F-8A3E-0D6F6A7B4E3B/Documents/ScenicSpots.sqlite

    
