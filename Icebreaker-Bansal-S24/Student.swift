import Foundation

class Student:Identifiable{
    var id: String
    var answer: String
    var txtclass = "ios-spring2024"
    var first_name: String
    var last_name: String
    var pref_name: String
    var question:String
    
    init? (id: String, data: [String: Any]){
//        guard let answer = data["answer"] as? String
//        else{
//            return nil
//        }
        self.id = id
        self.answer = data["answer"] as! String
        self.first_name = data["first_name"] as! String
        self.last_name = data["last_name"] as! String
        self.pref_name = data["pref_name"] as! String
        self.question = data["question"] as! String
    }
}
