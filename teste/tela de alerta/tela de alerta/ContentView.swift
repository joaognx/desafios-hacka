//
//  ContentView.swift
//  tela de alerta
//
//  Created by Turma02-18 on 27/05/26.
//

import SwiftUI


struct ContentView: View {
    @State  var text =  ""
    var body: some View {
        VStack {
            ZStack{
                Image("img")
                    .resizable()
                Image("onewish")
                    .resizable()
                    .frame(width: 410, height: 700)
                    .opacity(0.3)
            }
            TextField("Your name: ", text: $text)
                .multilineTextAlignment(.center)
            Text("Hello \(text)! You have One Wish Willow")
            button(text: text)
        }
        .padding()
    }
}

struct button: View {
    var text: String
    @State private var showingAlert = false
    var body: some View {
        Button("Make a Wish") {
            showingAlert = true
        }
        .font(.headline)
        .foregroundColor(Color.red)
        .alert("WHY DONT YOU LOVE ME \(text) ??!!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
                }
            }
        
    #Preview {
        ContentView()
    }
    

