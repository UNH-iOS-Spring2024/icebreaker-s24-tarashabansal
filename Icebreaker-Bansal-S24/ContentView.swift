//
//  ContentView.swift
//  Icebreaker-Bansal-S24
//
//  Created by Tarasha Bansal on 2/6/24.
//

import SwiftUI
import FirebaseFirestore


struct ContentView: View {
    var body: some View {
        TabView {
           IceBreakerForm()
             .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
              }
            StudentData()
                 .tabItem {
                    Image(systemName: "person.fill")
                    Text("Student List")
                  }
            QuestionForm()
                 .tabItem {
                    Image(systemName: "bubble.fill")
                    Text("Add Question")
                  }
        }
        
    }
}

#Preview {
    ContentView()
}
