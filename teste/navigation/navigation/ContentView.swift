//
//  ContentView.swift
//  navigation
//
//  Created by Turma02-18 on 29/05/26.
//

import SwiftUI

struct ContentView: View {
    @State var text : String = ""
    var body: some View {
            NavigationStack{
                Section(header: Text("Menu de Cores").font(.largeTitle).bold().foregroundColor(Color.black)){
                    VStack {
                        TextField("Digite aqui: ", text: $text).multilineTextAlignment(.center)
                        HStack{
                            navLink(nome: "paintbrush", cor: Color.pink, frase: text)
                            navLink(nome: "paintbrush.pointed", cor: Color.blue, frase: text)
                        }
                        HStack{
                            navLink(nome: "paintpalette", cor: Color.blue, frase: text)
                            ListLink(nome: "list.dash", cor: Color.purple)
                        }
                    }
                }.padding(.bottom, 150)
            }
    }
}

struct navLink: View {
    var nome : String = ""
    var cor : Color
    var frase: String = ""
    var body: some View {
            NavigationLink {
                ColorView(nome: nome, cor:cor, frase: frase)
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(cor)
                    .frame(width: 150, height: 150)
                    .overlay(
                        Image(systemName: nome)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 80)
                            .foregroundColor(Color.white)
                    )
            }
        }
}

struct ColorView: View {
    var nome : String = ""
    var cor : Color
    var frase: String = ""
    var body: some View{
            ZStack{
                cor
                    .ignoresSafeArea()
                Circle()
                    .frame(width: 270)
                VStack{
                    Image(systemName: nome).resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(cor).padding(60)
                    Text(frase)
            }
        }
    }
}

struct ListLink: View {
    var nome : String = ""
    var cor : Color
    var body: some View {
            NavigationLink {
                ListView()
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(cor)
                    .frame(width: 150, height: 150)
                    .overlay(
                        Image(systemName: nome)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 80)
                            .foregroundColor(Color.white)
                    )
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
