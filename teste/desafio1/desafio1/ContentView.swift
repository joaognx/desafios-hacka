//
//  ContentView.swift
//  teste
//
//  Created by Turma02-18 on 27/05/26.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                rect1(cor: Color.red)
                    .padding(.bottom, 200)
                    .padding(.horizontal, 90)
                
                rect1(cor: Color.blue)
                    .padding(.bottom, 200)
                    .padding(.horizontal, 90)
            }
            HStack{
                rect1(cor: Color.green)
                    .padding(.top, 200)
                    .padding(.horizontal, 90)
                rect1(cor: Color.yellow)
                    .padding(.top, 200)
                    .padding(.horizontal, 90)
            }
        } .padding()
        
    }
}

struct rect1: View {
    let cor: Color
    var body: some View {
            Rectangle()
                .fill(cor)
                .frame(width: 100, height: 100)
        }
    }

#Preview {
    ContentView()
}
