import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    
    @State private var classificationLabel = "Nenhuma imagem analisada ainda"
    @State private var selectedImage: UIImage? = UIImage(named: "leao")
    
    var body: some View {
        ZStack {
            if let image = selectedImage {
                texto(
                    selectedImage: image,
                    classificationLabel: $classificationLabel
                )
            }
        }
        .background(Color(.systemGray6))
    }
}

struct imagem: View {
    var selectedImage: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 250)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(.white, lineWidth: 10)
                        .frame(width: 250)
                )
            Spacer()
        }
    }
}

struct resultado: View {
    var classificationLabel: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "text.page.badge.magnifyingglass")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                
                Text("Resultado da análise")
                    .fontWeight(.bold)
            }
            
            Divider()
            
            Text(classificationLabel)
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        
        Spacer()
    }
}

func classifyImage(selectedImage: UIImage, classificationLabel: Binding<String>) {
    
    guard let ciImage = CIImage(image: selectedImage) else {
        classificationLabel.wrappedValue = "Erro ao converter imagem"
        return
    }
    
    do {
        let model = try VNCoreMLModel(
            for: MobileNetV2(configuration: MLModelConfiguration()).model
        )
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                
                DispatchQueue.main.async {
                    classificationLabel.wrappedValue =
                    "Identificado: \(topResult.identifier) (\(String(format: "%.2f", topResult.confidence * 100))%)"
                }
                
            } else {
                DispatchQueue.main.async {
                    classificationLabel.wrappedValue = "Nenhum resultado encontrado"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    classificationLabel.wrappedValue =
                    "Erro na classificação: \(error.localizedDescription)"
                }
            }
        }
        
    } catch {
        classificationLabel.wrappedValue = "Falha ao carregar modelo ML"
    }
}

struct texto: View {
    var selectedImage: UIImage
    @Binding var classificationLabel: String
    
    var body: some View {
        VStack(spacing: -10) {
            Text("MobileNet")
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text("Classificador de Imagem")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            
            imagem(selectedImage: selectedImage)
                .padding()
                .padding(.top)
            
            resultado(classificationLabel: classificationLabel)
                .padding()
                .padding(.top, 20)
            
            botao(
                selectedImage: selectedImage,
                classificationLabel: $classificationLabel
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top)
    }
}

struct botao: View {
    var selectedImage: UIImage
    @Binding var classificationLabel: String
    
    var body: some View {
        Button(action: {
            classifyImage(
                selectedImage: selectedImage,
                classificationLabel: $classificationLabel
            )
        }) {
            HStack(spacing: 8) {
                Image(systemName: "cpu")
                    .font(.body)
                
                Text("Analisar Agora")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(12)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ContentView()
}
