//
//  notes.swift
//  unwindSegue
//
//  Created by user on 2020/8/16.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
// struct Notes 是 Codeable 型別。typealias Codable = Decodable (readfile) & Encodable(save file 請留意以下兩個 func 的寫法)
struct Notes : Codable {
    var name : String
    var type : String
    var details : String
    var priority : String
    var others : String
    
    // 以 Encoder 存擋。這個 func 應用在 unwindSegue 寫在  editNotesTableView 當 按下 Done 時 的 func 存擋 中使用 請參考其程式碼。一定要研究清楚
    static func saveToFile (notes : [Notes]){
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(notes){
            UserDefaults.standard.set(data, forKey: "notes")
        }
        
    }
    
    //以 Decoder 讀取檔案，寫在 notesTableView 的 viewDidLoad 中
    static func readNotesFromFile () -> [Notes]? {
        let userDefaults = UserDefaults.standard
        let propertyDecoder = PropertyListDecoder()
        if let data = userDefaults.data(forKey : "notes"),
            let notes = try? propertyDecoder.decode([Notes].self, from: data){
            return notes
        }else {
    return nil
    }
    
    }
    
}
