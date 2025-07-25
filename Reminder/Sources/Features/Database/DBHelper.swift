//
//  DBHelper.swift
//  Reminder
//
//  Created by milet on 29/06/25.
//

import Foundation
import SQLite3

class DBHelper {
    static let share = DBHelper()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false).appendingPathComponent("Reminder.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir banco de dados")
        }
    }
    
    private func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Recipes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                remedy TEXT,
                time TEXT,
                recurrence TEXT,
                takeNow INTEGER
            );
            """
        
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Tabela criada com sucesso")
            } else {
                print("Erro na criação da tabela")
            }
        } else {
            print("CreateTable statement não conseguiu executar")
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertRecipe(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        let insertQuery = "INSERT INTO Recipes (remedy, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1 : 0))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita inserida com sucesso")
            } else {
                print("Falha ao inserir receita na tabela")
            }
        } else {
            print("INSERT statement falhou")
        }
        sqlite3_finalize(statement)
    }
    
    func fetchReceipts() -> [Medicine] {
        let fetchQuery = "SELECT * FROM Recipes"
        
        var statement: OpaquePointer?
        var receipts: [Medicine] = []
        
        if sqlite3_prepare(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let remedy = sqlite3_column_text(statement, 1).flatMap { String(cString: $0) } ?? "Unknwon"
                let time = sqlite3_column_text(statement, 2).flatMap { String(cString: $0) } ?? "Unknwon"
                let recurrence = sqlite3_column_text(statement, 3).flatMap { String(cString: $0) } ?? "Unknwon"
                
                receipts.append(Medicine(id: id,
                                         remedy: remedy,
                                         time: time,
                                         recurrence: recurrence))
            }
        } else {
            print("SELECT statement falhou")
        }
        
        sqlite3_finalize(statement)
        
        return receipts
    }
    
    func deleteReceipt(byId id: Int) {
        let deleteQuery = "DELETE FROM Recipes WHERE id = ?;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita Deletada")
            } else {
                print("Erro ao deletar receita")
            }
        } else {
            print("Delete statement falhou")
        }
        
        sqlite3_finalize(statement)
    }
}

