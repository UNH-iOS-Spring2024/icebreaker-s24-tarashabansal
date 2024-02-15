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
        VStack{
            Text("Student List")
                .font(.system(size: 40))
                .bold()
                .frame(width: .infinity)
            
            Table(students){
                
                TableColumn("Spring 2024") { student in
                    VStack(alignment: .leading) {
                        Text(student.first_name + " " + student.last_name)
                        Text(student.question + " - " + student.answer)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .tableStyle(InsetTableStyle())
            .onAppear(){
                getStudent()
            }
        }
    
    }
    
    func getStudent(){
        self.students = []
        db.collection("students")
        .getDocuments(){
            (querySnapshot,err) in
            if let err = err{ //error not nil
                print("Error getting documents: \(err)")
            }
            else{ //get students from db
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
