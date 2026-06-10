//
//  ContentView.swift
//  tabView
//
//  Created by Turma02-18 on 29/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Rosa", systemImage: "paintbrush") {
                ColorView(nome: "paintbrush", cor: Color.pink)
            }
            Tab("Azul", systemImage: "paintbrush.pointed") {
                ColorView(nome: "paintbrush.pointed", cor: Color.blue)
            }
            Tab("Cinza", systemImage: "paintpalette"){
                ColorView(nome: "paintpalette", cor: Color.gray)
            }
            Tab("Lista", systemImage: "list.dash"){
                ListView()
            }
        }
    }
}

struct ColorView: View {
    var nome : String = ""
    var cor : Color
    var body: some View{
        ZStack{
            cor
            .ignoresSafeArea()
            Circle()
                .frame(width: 270)
            Image(systemName: nome).resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(cor)
        }
    }
}

struct ListView: View {
    
    var body: some View{
        ZStack{
            VStack{
                List{
                    Section(header: Text("List").font(.largeTitle).bold().foregroundColor(Color.black)){
                        NamesView(nome: "paintbrush.fill")
                        NamesView(nome: "paintbrush.pointed.fill")
                        NamesView(nome: "paintpalette.fill")
                    }
                }
            }
        }
    }
}

struct NamesView: View {
    var nome: String = ""
    var body: some View{
        HStack{
            Text("Item")
            Spacer()
            Image(systemName: nome)
            .resizable()
            .frame(width: 20, height: 20)
        }
    }
}



#Preview {
    ContentView()
}
