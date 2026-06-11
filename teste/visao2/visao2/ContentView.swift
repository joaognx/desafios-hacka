//
//  ContentView.swift
//  visao2
//
//  Created by Turma02-18 on 11/06/26.
//

import SwiftUI
import UIKit
import Vision
import PhotosUI
import AVFoundation



func recognizeText(from image: UIImage, completion: @escaping (String) -> Void) {
    guard let cgImage = image.cgImage else { return }

    let request = VNRecognizeTextRequest { request, error in
        guard let observations = request.results as? [VNRecognizedTextObservation],
              error == nil else {
            print("Erro ao reconhecer texto")
            return
        }

        var extractedText = ""

        for observation in observations {
            if let topCandidate = observation.topCandidates(1).first {
                extractedText += topCandidate.string + "\n"
            }
        }

        DispatchQueue.main.async {
            completion(extractedText)
        }
    }

    request.recognitionLevel = .accurate
    request.recognitionLanguages = ["pt-BR", "en-US"]

    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

    do {
        try handler.perform([request])
    } catch {
        print("Falha ao realizar a requisição: \(error)")
    }
}

struct ContentView: View {
    let sintetizador = AVSpeechSynthesizer()

    @State var photoPicked: PhotosPickerItem?
    @State var imageToAnalise: UIImage?
    @State var detectedText: String = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                titulo()

                if imageToAnalise != nil {
                    Image(uiImage: imageToAnalise!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)

                    NiceButtonView(
                        title: "Escutar Texto",
                        color: .indigo,
                        imageToAnalise: $imageToAnalise,
                        detectedText: $detectedText
                    ) {
                        let enunciado = AVSpeechUtterance(string: detectedText)
                        enunciado.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                        enunciado.rate = 0.3
                        sintetizador.speak(enunciado)
                    }
                        
                    Spacer()
                    galeria(photoPicked: $photoPicked, imageToAnalise: $imageToAnalise)
                } else {
                    VStack {
                        Spacer()
                        Text("Nenhuma foto para analisar")
                            .foregroundColor(.white)

                        galeria(photoPicked: $photoPicked, imageToAnalise: $imageToAnalise)
                    }
                }
            }
        }
    }
}

struct NiceButtonView: View {
    var title: String
    var color: Color

    @Binding var imageToAnalise: UIImage?
    @Binding var detectedText: String

    var action: () -> Void

    var body: some View {
        Button {
            if let image = imageToAnalise {
                recognizeText(from: image) { texto in
                    detectedText = texto
                    action()
                }
            }
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .cornerRadius(10)
        }
    }
}

struct galeria : View {
    @Binding var photoPicked : PhotosPickerItem?
    @Binding var imageToAnalise : UIImage?
    var body: some View {
        PhotosPicker(selection: $photoPicked,
                     matching: .images,
                     photoLibrary: .shared()) {
            Text("Pegar da Galeria")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.indigo)
                .foregroundStyle(.white)
                .cornerRadius(25)
                .padding(.horizontal)
        }
                     .onChange(of: photoPicked) { oldValue, newValue in
                         if let newPhoto = newValue {
                             Task {
                                 if let data = try? await newPhoto.loadTransferable(type: Data.self),
                                    let image = UIImage(data: data) {
                                     // Necessitamos da imagem ser do tipo UIImage para realizar a analise
                                     imageToAnalise = image
                                 }
                             }
                         }
                     }
        Spacer()
    }
}

struct titulo : View {
    var body: some View {
        Text("StudyCast")
            .font(.headline)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.top)
        Spacer()
        
    }
}

#Preview {
    ContentView()
}
