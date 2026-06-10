//
//  ContentView.swift
//  mapkit
//
//  Created by Turma02-18 on 02/06/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var locais: [Location] = [
            // 1. Cristo Redentor — Rio de Janeiro, Brasil
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Christ_the_Redeemer_-_Cristo_Redentor.jpg/500px-Christ_the_Redeemer_-_Cristo_Redentor.jpg",
                nome: "Cristo Redentor",
                descricao: "Estátua de Jesus Cristo no topo do Corcovado, símbolo do Rio de Janeiro e do Brasil.", coordinate: CLLocationCoordinate2D(
                latitude: -22.951889,
                longitude: -43.210500)
            ),
            // 2. Chichén Itzá — Yucatán, México
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Chichen_Itza_3.jpg/500px-Chichen_Itza_3.jpg",
                nome: "Chichén Itzá",
                descricao: "Complexo maia famoso pela pirâmide de Kukulcán e por sua precisão astronômica.",
                coordinate: CLLocationCoordinate2D(
                latitude: 20.684285,
                longitude: -88.567783)
            ),
            // 3. Coliseu — Roma, Itália
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Colosseo_2020.jpg/500px-Colosseo_2020.jpg",
                nome: "Coliseu",
                descricao: "Anfiteatro romano icônico, palco de espetáculos e símbolo da Roma Antiga.",
                coordinate:
                CLLocationCoordinate2D(
                latitude: 41.890210,
                longitude: 12.492231)
            ),
            // 4. Machu Picchu — Cusco, Peru
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Machu_Picchu%2C_Peru.jpg/500px-Machu_Picchu%2C_Peru.jpg",
                nome: "Machu Picchu",
                descricao: "Cidade inca nos Andes, famosa por sua engenharia e paisagens espetaculares.",
                coordinate:
                CLLocationCoordinate2D(
                latitude: -13.163141,
                longitude: -72.544963)
            ),
            // 5. Taj Mahal — Agra, Índia
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Taj-Mahal.jpg/500px-Taj-Mahal.jpg",
                nome: "Taj Mahal",
                descricao: "Mausoléu de mármore branco, símbolo de amor e uma obra-prima da arquitetura mogol.",
                coordinate: CLLocationCoordinate2D(
                latitude: 27.175015,
                longitude: 78.042155)
            ),
            // 6. Grande Muralha da China — China
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/20090529_Great_Wall_8185.jpg/500px-20090529_Great_Wall_8185.jpg",
                nome: "Grande Muralha da China",
                descricao: "Imensa fortificação que se estende por milhares de quilômetros no norte da China.",
                coordinate: CLLocationCoordinate2D(
                latitude: 40.431908,
                longitude: 116.570374)
            ),
            // 7. Petra — Jordânia
            Location(
                foto: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Al_Khazneh.jpg/500px-Al_Khazneh.jpg",
                nome: "Petra",
                descricao: "Cidade esculpida na rocha pelos nabateus, famosa pelo Tesouro (Al-Khazneh).",
                coordinate: CLLocationCoordinate2D(
                latitude: 30.328960,
                longitude: 35.444832)
            )
        ]
    @State var selectedPlace = "Cristo Redentor"
    var body: some View {
        NavigationStack{
            ZStack{
                mapa(locais: $locais, selectedPlace: $selectedPlace, foto: "sla", descricao: "sla")
                VStack{
                    Picker("Please choose a place", selection: $selectedPlace) {
                        ForEach(locais) { local in
                            Label(local.nome, systemImage: "circle.fill")
                                .foregroundStyle(.red)
                                .tag(local.nome)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


struct mapa: View {
    @Binding var locais: [Location]
    @Binding var selectedPlace: String
    let  foto: String
    let descricao: String

    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -22.951889, longitude: -43.210500),
            span: MKCoordinateSpan(latitudeDelta: -22.951889, longitudeDelta: -43.210500)
        )
    )

    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(locais) { local in
                    Annotation(local.nome, coordinate: local.coordinate) {
                        NavigationLink{
                            SwiftUIView(local: local)
                        } label: {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title)
                        }
                    }
                }
            }
            .onChange(of: selectedPlace) { _, novoLugar in
                if let local = locais.first(where: { $0.nome == novoLugar }) {
                    position = .region(
                        MKCoordinateRegion(
                            center: local.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct Location : Identifiable {
    let id = UUID()
    let foto: String
    let nome: String
    let descricao: String
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    ContentView()
}
