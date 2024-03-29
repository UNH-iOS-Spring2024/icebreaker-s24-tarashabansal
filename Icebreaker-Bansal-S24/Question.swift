//
//  Question.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/6/24.
//

import Foundation

class Question: Identifiable{
    var id: String
    var text: String
    
    init? (id: String, data: [String: Any]){
        guard let text = data["text"] as? String
        else{
    return nil
        }
        self.id = id
        self.text = text
    }
}
