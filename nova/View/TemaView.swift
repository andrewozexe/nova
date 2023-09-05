import SwiftUI

struct TemaView: View {
    
    var onCompletion: ((Estrela) -> Void)?
    var estrela: Estrela
    
    @State private var titulo: String = ""
    @State private var texto: String = ""
    
    var body: some View {
        ZStack{
            ZStack{
                VStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 5) {
                        Spacer()
                        VStack(alignment: .center, spacing: 4) {
                            TextField("Tema", text: $titulo)
                                .cornerRadius(8)
                                .font(
                                    Font.custom("Kodchasan", size: 18)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            HStack(alignment: .center, spacing: 4) {
                                Text("Planeta gasoso")
                                    .font(
                                        Font.custom("SF Pro", size: 9)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.black)
                            }
                            .padding(0)
                            Text("20 dias de vida restante")
                                .font(Font.custom("Inter", size: 9))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 124, alignment: .top)
                        }.padding(10)
                        
                            
                        TextField("Reflexão", text: $texto, axis: .vertical)
                            .autocorrectionDisabled()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .frame(width: 260, height: 246, alignment: .topLeading)
                        
                        Button {
                            let novaReflexao = Reflexao(titulo: self.titulo, texto: self.texto)
                            let novaEstrela = Estrela(reflexao: novaReflexao, x: estrela.x, y: estrela.y)
                            Manager.shared.estrela = novaEstrela
                            Manager.shared.showView = false
                            
                        } label: {
                            Text(.init(systemName: "plus.circle.fill"))
                                .font(.system(size: 32))
                                .foregroundColor(.black)
                        }
                        .padding(.bottom ,24)
                        Spacer()
                    }
                    .padding(.top, 85/2)
                    .frame(width: 300, height: 445, alignment: .top)
                    .background(.white)
                    .cornerRadius(16)
                }
                
                VStack{
                    Circle()
                        .strokeBorder(Color.white,lineWidth: 2)
                        .background(Circle().foregroundColor(Color.black))
                        .frame(width: 85, height: 85)
                    Spacer()
                }
            }
            .frame(width: 300, height: 487.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.black)

        
    }
}

struct LengthLimitingTextField: View {
    @Binding var text: String
    let limit: Int

    var body: some View {
        TextField("Texto", text: $text)
            .onChange(of: text) { newValue in
                if newValue.count > limit {
                    text = String(newValue.prefix(limit))
                }
            }
            .multilineTextAlignment(.leading) // Alinha à esquerda
            .padding(.top, 5) // Ajuste conforme necessário para alinhar à parte superior
    }
}



struct TemaView_Previews: PreviewProvider {
    static var previews: some View {
        TemaView(estrela: Estrela(reflexao: Reflexao(titulo: "Amor", texto: "Todos amam"), x: 0, y: 0))
    }
}
