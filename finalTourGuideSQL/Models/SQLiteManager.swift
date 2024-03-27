//
//  File.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

struct ScenicSpot: Identifiable {
    var id: Int
    var title: String
    var description: String
    var imageUrl: String
}


import Foundation
import SQLite3

class DatabaseManager {
    var db: OpaquePointer?

    init() {
        openDatabase()
        createTable()
    }

    func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ScenicSpots.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }

    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS ScenicSpots(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Title CHAR(255),
        Description TEXT,
        ImageUrl CHAR(255));
        """

        if sqlite3_exec(db, createTableString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    // 添加更多的数据库操作方法（插入、查询等）
    //添加
    func insertScenicSpot(spot: ScenicSpot) {
        let insertStatementString = "INSERT INTO ScenicSpots (Title, Description, ImageUrl) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (spot.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (spot.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (spot.imageUrl as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    //查询
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

                spots.append(ScenicSpot(id: id, title: title, description: description, imageUrl: imageUrl))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return spots
    }
    
    //fetchall
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

                spots.append(ScenicSpot(id: id, title: title, description: description, imageUrl: imageUrl))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return spots
    }
    
    //删除
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

