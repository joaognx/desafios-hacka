//
//  ContentView.swift
//  gastrobar
//
//  Created by Turma02-18 on 12/06/26.
//

import SwiftUI
import Vision
import CoreML
import Translation
import AVFoundation

struct Comida : Hashable {
    var nome : String
    var imagem : String
    var valor : Double
    var tipo: String
}

struct ContentView: View {
    
    @State private var arrayComidas : [Comida] = [
        Comida(nome: "teste", imagem: "teste", valor: 10, tipo: "entrada"),
        Comida(nome: "teste", imagem: "teste", valor: 10, tipo: "entrada"),
        Comida(nome: "teste", imagem: "teste", valor: 10, tipo: "entrada")
    ]
    
    
    @State private var textoSelecionado = ""
    @State private var mostrarTraducao = false
    
    var body: some View {
        
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    Text("Hackatruck Gastrobar")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    Spacer()
                }
                VStack
                {
                    Text("ENTRADA")
                    ForEach(arrayComidas, id: \.self){ c in
                        if (c.tipo == "entrada"){
                            ComponentView(comida: c, mostrarTraducao: mostrarTraducao, textoSelecionado: textoSelecionado)
                        }
                    }
                    Spacer()
                }.padding(.top, 60)
                VStack
                {
                    Text("PRINCIPAL")
                    ForEach(arrayComidas, id: \.self){ c in
                        if (c.tipo == "principal"){
                            ComponentView(comida: c, mostrarTraducao: mostrarTraducao, textoSelecionado: textoSelecionado)

                        }
                    }
                    Spacer()
                }.padding(.top)
                
            }
        }.translationPresentation(
            isPresented: $mostrarTraducao,
            text: textoSelecionado)
    }
}

struct ComponentView: View {
    
    let comida : Comida
    let mostrarTraducao : Bool
    var textoSelecionado: String
    
    var body: some View {
        HStack{
            
            Image(comida.imagem)
            VStack(alignment: .leading) {
                Text(comida.nome)
                Text("R$ \(String(format: "%.2f", comida.valor))")
                Divider()
            }
            Button {
                textoSelecionado = comida.nome
                mostrarTraducao = true
            } label: {
                Image(systemName: "translate")
            }
        }.background(.blue)
            .frame(width: .infinity)
            .padding(.horizontal, 20)
    }
}

#Preview {
    ContentView()
}
