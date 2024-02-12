//
//  IceBreakerForm.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/7/24.
//

import SwiftUI
import FirebaseFirestore

struct IceBreakerForm: View {
    let db = Firestore.firestore()
    
    @State var txtFirstname: String = ""
    @State var txtlastname: String = ""
    @State var txtPreferredname: String = ""
    @State var txtQuestion: String = ""
    @State var txtAnswer: String = ""
    @State var questions = [Question]()
    var body: some View {
        VStack {
            Image("ice1")
                .resizable()
                .frame(width: 150.0, height: 130.0)
            Text("Icebreaker")
                .font(.system(size: 40))
                .bold()
            Text("Build with SwiftUI")
            TextField("First Name",text: $txtFirstname)
            TextField("Last Name",text: $txtlastname)
            TextField("Preferred Name",text: $txtPreferredname)
            HStack{
                Text(txtQuestion)
                    .font(.title)
                    .padding(.trailing, 20)
                    .fixedSize(horizontal: false, vertical: true)
                Button(action:{setRandomQuestion()}){
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
                .padding(10)
                .frame(maxWidth: 2)
                .foregroundColor(.black)
            }
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
            .frame(maxWidth: . infinity)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .cornerRadius(10)
        }
        .font(.title)
        .multilineTextAlignment(.center)
        .autocorrectionDisabled(true)
        .padding()
        .onAppear(){
            getQuestion()
        }
        
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
                        //                        print("\(document.documentID)")
                        if let question = Question(id: document.documentID, data: document.data()){
                            //                            print("\(question.text)")
                            self.questions.append(question)
                        }
                    }
                    setRandomQuestion()
                }
                
            }
        
    }
    func setRandomQuestion(){
        let newQuestion = questions.randomElement()?.text
        self.txtQuestion = newQuestion!
    }

   
}

#Preview {
    IceBreakerForm()
}
