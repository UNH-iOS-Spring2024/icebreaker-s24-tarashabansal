//
//  ContentView.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/6/24.
//

import SwiftUI


struct ContentView: View {
    @State var txtFirstname: String = ""
    @State var txtlastname: String = ""
    @State var txtPreferredname: String = ""
    @State var txtQuestion: String = ""
    @State var txtAnswer: String = ""
    
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
            
            Button(action:{submitStudent()}){
                Text("Submit")
                    .font(.system(size: 28))
            }
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .autocorrectionDisabled(true)
        .padding()
    }
    func setRandomQuestion(){
        print("Hello \(txtFirstname)")
    }
    func submitStudent(){
        print("Hello \(txtFirstname)")
    }
}

#Preview {
    ContentView()
}
