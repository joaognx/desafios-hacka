//
//  ContentView.swift
//  harryPotterAPI
//
//  Created by Turma02-18 on 03/06/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            ZStack {
                Color.wine
                    .ignoresSafeArea()
                VStack(spacing: -50){
                    Image("grifii").resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    personagens()
                }
            }
            .onAppear(){
                viewModel.fetch()
            }
        }
    }
}

struct personagens: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewModel.personagens){ personagem in
                    NavigationLink{
                        CharacterView(character: personagem)
                    } label : {
                        HStack{
                            if let url = URL(string: personagem.image!) {
                                AsyncImage(url: URL(string: personagem.image!)) { image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                    //
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 80, height: 110)
                                Text(personagem.name!).foregroundColor(.orange)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }.padding().onAppear(){viewModel.fetch()}
    }
}
#Preview {
    ContentView()
}
