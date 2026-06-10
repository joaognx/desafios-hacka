//
//  ContentView.swift
//  velocidadeAnimais
//
//  Created by Turma02-18 on 28/05/26.
//

import SwiftUI

var cor: Color = .gray


struct ContentView: View {
    @State var km: Double = 0
    @State var hora: Double = 0
    @State var resultado: Double = 0
    @State var img: String = ""
    var body: some View {
        ZStack{
            cor
            .ignoresSafeArea()
            VStack {
                VStack{
                    Text("Digite a distância (km):")
                    TextField("0", value: $km, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)
                        .textFieldStyle(.roundedBorder)
                    Text("Digite o tempo (h):")
                    TextField("0", value: $hora, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)
                        .textFieldStyle(.roundedBorder)
                    buttonCalcular(resultado: $resultado, km: km, hora: hora)
                }
                VStack{
                    Text("\(resultado, specifier:"%.2f") km/h").font(.largeTitle)
                    if (resultado > 0 && resultado <= 9.9) {
                        Imagens(named: "turtle")
                    }
                    else if (resultado >= 10 && resultado <= 29.9){
                        Imagens(named: "elephant")
                    }
                    else if (resultado >= 30 && resultado <= 69.9){
                        Imagens(named: "ostrich")
                    }
                    else if (resultado >= 90 && resultado <= 130){
                        Imagens(named: "guepardo")
                    }
                    else if (resultado >= 70 && resultado <= 89.9){
                        Imagens(named: "lion")
                    }
                    else{
                        Imagens(named: "?")
                    }
                }
                
                sumario()
                                
            }
            .padding()
        }
    }
}

@ViewBuilder func Imagens(named nome: String) ->  some View{
    Image(nome)
        .resizable()
        .clipShape(Circle())
        .frame(maxWidth: 400, maxHeight:400)
        
}

struct sumario: View {
    var body: some View {
        VStack() {
            HStack{
                Text("TARTARUGA")
                Text("(0 - 9.9km/h)")
                Spacer()
                Circle()
                    .fill(.verde)
                    .frame(width: 10)
                    
            }
            HStack{
                Text("ELEFANTE")
                Text("(10 - 29.9km/h)")
                Spacer()
                Circle()
                    .fill(.ciano)
                    .frame(width: 10)
                    
                    
            }
            HStack{
                Text("AVESTRUZ")
                Text("(30 - 69.9km/h)")
                Spacer()
                Circle()
                    .fill(.laranja)
                    .frame(width: 10)
                    
            }
            HStack{
                Text("LEÃO")
                Text("(70 - 89.9km/h)")
                Spacer()
                Circle()
                    .fill(.amarelo)
                    .frame(width: 10)
                    
                    
            }
            HStack{
                Text("GUEPARDO")
                Text("(90 - 130.9km/h)")
                Spacer()
                Circle()
                    .fill(.vermelho)
                    .frame(width: 10)
                    
            }
        }.background(.white)
            .frame(width: 250)

    }
}

struct buttonCalcular: View {
    @Binding var resultado: Double
    var km: Double
    var hora: Double
    var body: some View {
        Button(action: {
            resultado = Calcular(km: km, hora: hora)
            mudarCor(resultado: resultado)
        }){
            Text("Calcular")
        }.font(.headline)
            .foregroundStyle(.orange)
            .padding()
            .frame(maxWidth: 100)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

func Calcular (km : Double, hora: Double) -> Double {
    let velocidade : Double = km/hora
    
    return velocidade
}

func mudarCor(resultado: Double){
    if (resultado > 0 && resultado <= 9.9) {
        cor = .green
    }
    else if (resultado >= 10 && resultado <= 29.9){
        cor = .ciano
    }
    else if (resultado >= 30 && resultado <= 69.9){
        cor = .laranja
    }
    else if (resultado >= 90 && resultado <= 130){
        cor = .vermelho
    }
    else if (resultado >= 70 && resultado <= 89.9){
        cor = .amarelo
    }
    else{
        cor = .gray
    }
}

#Preview {
    ContentView()
}

