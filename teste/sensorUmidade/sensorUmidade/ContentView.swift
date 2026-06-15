import SwiftUI
import Foundation
import Combine
import Charts

struct LeituraUmidade: Identifiable {
    let id = UUID()
    let data = Date()
    let valor: Int
}

class SensorViewModel: ObservableObject {

    @Published var umidade = 0
    @Published var historico: [LeituraUmidade] = []

    private var webSocketTask: URLSessionWebSocketTask?

    func conectar() {

        guard webSocketTask == nil else { return }

        let url = URL(string: "ws://192.168.128.114:81")!

        webSocketTask = URLSession.shared.webSocketTask(with: url)

        webSocketTask?.resume()

        receber()
    }

    func desconectar() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
    }

    private func receber() {

        webSocketTask?.receive { [weak self] result in

            guard let self = self else { return }

            switch result {

            case .success(let message):

                switch message {

                case .string(let texto):

                    self.processarMensagem(texto)

                case .data(let data):

                    if let texto = String(data: data, encoding: .utf8) {
                        self.processarMensagem(texto)
                    }

                @unknown default:
                    break
                }

                self.receber()

            case .failure(let erro):

                print("Erro WebSocket:", erro)

                self.webSocketTask = nil

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.conectar()
                }
            }
        }
    }

    private func processarMensagem(_ texto: String) {

        guard let data = texto.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return
        }

        var valor = 0

        if let intValue = json["umidade"] as? Int {
            valor = intValue
        } else if let doubleValue = json["umidade"] as? Double {
            valor = Int(doubleValue)
        } else if let stringValue = json["umidade"] as? String,
                  let intValue = Int(stringValue) {
            valor = intValue
        }

        DispatchQueue.main.async {

            self.umidade = valor

            self.historico.append(
                LeituraUmidade(valor: valor)
            )

            if self.historico.count > 50 {
                self.historico.removeFirst()
            }
        }
    }
}

struct ContentView: View {

    @State private var isShowingSheet = false
    @StateObject private var umi = SensorViewModel()

    var porcentagem: Int {

        let valor = 100 - ((umi.umidade * 100) / 1024)

        return min(max(valor, 0), 100)
    }

    var body: some View {

        VStack(spacing: 20) {

            if porcentagem < 50 {

                Image("triste")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

            } else {

                Image("feliz")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }

            Text("\(porcentagem)%")
                .font(.system(size: 40, weight: .bold))

            ZStack(alignment: .bottom) {

                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 5)
                    .frame(width: 175, height: 225)

                RoundedRectangle(cornerRadius: 15)
                    .fill(.blue)
                    .frame(
                        width: 150,
                        height: 225 * CGFloat(porcentagem) / 100
                    )
            }

            Button("Gráficos") {
                isShowingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            umi.conectar()
        }
        .onDisappear {
            umi.desconectar()
        }
        .sheet(isPresented: $isShowingSheet) {

            DetalheView(
                historico: umi.historico
            )
        }
    }
}

struct DetalheView: View {

    @Environment(\.dismiss) private var dismiss

    let historico: [LeituraUmidade]

    var body: some View {

        NavigationStack {

            VStack {

                if historico.isEmpty {

                    ContentUnavailableView(
                        "Sem dados",
                        systemImage: "chart.line.uptrend.xyaxis"
                    )

                } else {

                    Chart(historico) { item in

                        LineMark(
                            x: .value("Horário", item.data),
                            y: .value("Umidade", item.valor)
                        )
                        .foregroundStyle(.blue)

                        PointMark(
                            x: .value("Horário", item.data),
                            y: .value("Umidade", item.valor)
                        )
                        .foregroundStyle(.blue)
                    }
                    .frame(height: 300)
                    .padding()
                }
            }
            .navigationTitle("Histórico")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
