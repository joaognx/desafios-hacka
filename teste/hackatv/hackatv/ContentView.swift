//  ContentView.swift
//  hackatv
//  Created by Turma02-18 on 01/06/26.


import SwiftUI

struct ContentView: View {
    
    
    @State var arrayConteudo: [Conteudo] = [Conteudo(categoria: "Filme", ano: "2019", capa: "https://static.wikia.nocookie.net/listofdeaths/images/9/98/Us_poster.jpg/revision/latest/scale-to-width-down/300?cb=20200707042849", nome: "Us", genero: "Terror", pais: "🇺🇸", imbd: 6.8),
        Conteudo(categoria: "Filme", ano: "2019", capa: "https://static.wikia.nocookie.net/listofdeaths/images/9/98/Us_poster.jpg/revision/latest/scale-to-width-down/300?cb=20200707042849", nome: "Us", genero: "Terror", pais: "🇺🇸", imbd: 6.8),
                                            Conteudo(categoria: "Filme", ano: "2019", capa: "https://static.wikia.nocookie.net/listofdeaths/images/9/98/Us_poster.jpg/revision/latest/scale-to-width-down/300?cb=20200707042849", nome: "Us", genero: "Terror", pais: "🇺🇸", imbd: 6.8)
    ]
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray, .gray, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    scrollVertical(arrayConteudo: arrayConteudo, titulo: "Filmes")
                    ScrollHorizontal(arrayConteudo: arrayConteudo, titulo: "Recomendados")
                }
                    .padding()
                }
            }
        }
    }

    
    struct scrollVertical: View {
        var arrayConteudo : [Conteudo]
        var titulo : String = ""
        var body: some View {
            VStack (alignment: .leading, spacing: 10){
                Text(titulo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ScrollView{
                    VStack(spacing: -10){
                        ForEach(arrayConteudo, id: \.self) { midia in
                            NavigationLink{
                                MovieView(capa: midia.capa, nome: midia.nome, categoria: midia.categoria, ano: midia.ano, genero: midia.genero, pais: midia.pais, imdb: midia.imbd)
                            }label: {
                                HStack{
                                    if let url = URL(string: midia.capa) {
                                        AsyncImage(url: URL(string: midia.capa)) { image in
                                            image
                                                .resizable()
                                            //
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 50, height: 70)
                                        VStack{
                                            Text(midia.nome).foregroundColor(Color.black)
                                            Text(midia.ano).foregroundColor(Color.black)
                                        }
                                        Spacer()
                                        Text(midia.pais)
                                            .padding()
                                        
                                    }
                                }
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                            //                            .frame(width: 350)
                                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4))
                                .padding()
                            }
                        }
                    }
                }
            }.padding()
        }
    }



    struct ScrollHorizontal: View {
        var arrayConteudo : [Conteudo]
        var titulo : String = ""
        var body: some View {
            VStack (alignment: .leading, spacing: 10){
                Text(titulo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(arrayConteudo, id: \.self) { midia in
                            NavigationLink{
                                MovieView(capa: midia.capa, nome: midia.nome, categoria: midia.categoria, ano: midia.ano, genero: midia.genero, pais: midia.pais, imdb: midia.imbd)
                            }label: {
                                if let url = URL(string: midia.capa) {
                                    AsyncImage(url: URL(string: midia.capa)) { image in
                                        image
                                            .resizable()
                                        //
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 130, height: 170)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    struct MovieView: View {
        var capa : String = ""
        var nome : String = ""
        var categoria : String = ""
        var ano: String = ""
        var genero: String = ""
        var pais: String = ""
        var imdb: Double
        var body: some View{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.gray, .gray, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    if let url = URL(string: capa) {
                        AsyncImage(url: URL(string: capa)) { image in
                            image
                                .resizable()
                            //
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 70)
                        Text(nome)
                    }
                }
            }
        }
    }
    struct Conteudo : Hashable {
        let categoria: String
        let ano: String
        let capa: String
        let nome: String
        let genero: String
        let pais: String
        let imbd: Double
    }

    #Preview {
        ContentView()
    }
