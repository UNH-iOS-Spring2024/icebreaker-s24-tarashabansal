//
//  StudentData.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/7/24.
//

import SwiftUI
import FirebaseFirestore

struct StudentData: View {
    let db = Firestore.firestore()
    @State var students = [Student]()

    var body: some View {
        List{
            
            ForEach(students) { student in
                let fname = student.first_name
                let lname = student.last_name
                let ques = student.question
                let ans = student.answer
                Text(fname + " " + lname)
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .listRowSeparator(.hidden)
                Text(ques + "\nAnswer: " + ans)
                
                Spacer()
            }
        }
        .onAppear(){
            getStudent()
        }
    }
    
    func getStudent(){
        db.collection("students")
        .getDocuments(){
            (querySnapshot,err) in
            if let err = err{ //error not nil
                print("Error getting documents: \(err)")
            }
            else{ //get questions from db
                for document in querySnapshot!.documents{
                    print("\(document.documentID)")
                    if let student = Student(id:document.documentID, data: document.data()){
                        print("\(student)")
                        self.students.append(student)
                    }
                }
            }
        }   
    }
}
#Preview {
    StudentData()
}
