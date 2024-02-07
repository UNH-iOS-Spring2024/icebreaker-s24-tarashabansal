//
//  ContentView.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/6/24.
//

import SwiftUI
import FirebaseFirestore


struct ContentView: View {
    let db = Firestore.firestore()
    
    @State var txtFirstname: String = ""
    @State var txtlastname: String = ""
    @State var txtPreferredname: String = ""
    @State var txtQuestion: String = ""
    @State var txtAnswer: String = ""
    @State var questions = [Question]()
    var body: some View {
        VStack {
            
            Text("Icebreaker")
                .font(.system(size: 40))
                .bold()
            Text("Build with SwiftUI")
            TextField("First Name",text: $txtFirstname)
            TextField("Last Name",text: $txtlastname)
            TextField("Preferred Name",text: $txtPreferredname)
            
            Button(action:{setRandomQuestion()}){
                Text("Get a new random question")
                    .font(.system(size: 28))
            }
            Text(txtQuestion)
            TextField("Answer",text: $txtAnswer)
            
            Button(action:{
                if (txtAnswer != ""){
                    submitStudent()
                }
                resetTextFields()
                
            }){
                Text("Submit")
                    .font(.system(size: 28))
            }
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .autocorrectionDisabled(true)
        .padding()
        .onAppear(){
            getQuestion()
        }
    }
    func setRandomQuestion(){
        var newQuestion = questions.randomElement()?.text
        self.txtQuestion = newQuestion!
    }
    func submitStudent(){
        let data = ["first_name":txtFirstname,
                    "last_name":txtlastname,
                    "pref_name":txtPreferredname,
                    "question":txtQuestion,
                    "answer":txtAnswer,
                    "class":"ios-spring2024"] as [String:Any]
        var ref: DocumentReference? = nil
        ref = db.collection("students")
            .addDocument(data: data){ err in
                if let err = err{
                    print("Error in adding doc \(err)")
                }
                else{
                    print("Document added with ID : \(ref!.documentID)")
                }
            }
        
    }
    func resetTextFields(){
        txtFirstname=""
        txtlastname=""
        txtQuestion=""
        txtAnswer=""
        txtPreferredname=""
    }
    func getQuestion(){
        db.collection("questions")
            .getDocuments(){
                (querySnapshot,err) in
                if let err = err{ //error not nil
                    print("Error getting documents: \(err)")
                }
                else{ //get questions from db
                    for document in querySnapshot!.documents{
                        print("\(document.documentID)")
                        if let question = Question(id:
                                                    document.documentID, data: document.data()){
                            print("\(question.text)")
                            self.questions.append(question)
                        }
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
