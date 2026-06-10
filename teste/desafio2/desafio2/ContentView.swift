//
//  ContentView.swift
//  desafio2
//
//  Created by Turma02-18 on 27/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image("ha")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 100, height:100)
            VStack{
                Text("Homem-Aranha")
            }
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
