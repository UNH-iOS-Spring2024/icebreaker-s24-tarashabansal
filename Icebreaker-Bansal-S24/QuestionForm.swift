//
//  QuestionForm.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/12/24.
//

import SwiftUI
import FirebaseFirestore



struct QuestionForm: View {
    let db = Firestore.firestore()
    
    @State var txtNewQues: String = ""
    @State var questions = [Question]()
    var body: some View {
        VStack{
            TextField("Add a new question",text: $txtNewQues)
            Button(action:{
                if (txtNewQues != ""){
                    submitStudent()
                }
                resetTextFields()
            }){
                Text("Submit")
            }
            . frame(maxWidth: . infinity)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .cornerRadius(10)
            List{
                
                ForEach(questions) { question in
                    Text(question.text)
                }
            }
            .background()
            .onAppear(){
                getQuestion()
            }
            .scrollContentBackground(.hidden)
            .frame(maxHeight:500)
            
        }
        .padding()
        .multilineTextAlignment(.center)
        .autocorrectionDisabled(true)
        .font(.title2)
        
    }
       
        func submitStudent(){
            
            let data = ["text":txtNewQues,] as [String:Any]
            var ref: DocumentReference? = nil
            ref = db.collection("questions")
                .addDocument(data: data){ err in
                    if let err = err{
                        print("Error in adding doc \(err)")
                    }
                    else{
                        print("Document added with ID : \(ref!.documentID)")
                    }
                }
            getQuestion()
            
        }
        func resetTextFields(){
            txtNewQues=""
        }
        func getQuestion(){
            self.questions = [Question]()
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
                    }
                    
                }
            
        }
}

#Preview {
    QuestionForm()
}



   

