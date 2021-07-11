//
//  EditarRecebidos.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI

struct EditarRecebidos: View {
    let recebidos : Recebidos
    @State var nomeRecebido = ""
    @State var valorRecebido = "0.0"
    @State var dataRecebido = Date()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            Form{
                Text("Editar despesa")
                    .font(.headline)
                TextField(recebidos.nome ?? "" ,text:$nomeRecebido)
                TextField("Valor" ,text:$valorRecebido).keyboardType(.numberPad)

                DatePicker("Data do recebido : ",selection:$dataRecebido,displayedComponents:.date)
                
                Button("atualizar"){
                    
                    if !(nomeRecebido.isEmpty) {
                        recebidos.nome = self.nomeRecebido
                    }
                    
                    if !(valorRecebido.isEmpty && Double(valorRecebido) ?? 0.0 > 0) {
                        recebidos.valor = Double(valorRecebido) ?? 0.0
                    }
                    
                    recebidos.data = dataRecebido
                    
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                .frame(width:300,height:40)
                .cornerRadius(12)
                .foregroundColor(.white)
                .background(Color.blue)
                
            }
        }
    }
}

struct EditarRecebidos_Previews: PreviewProvider {
    static var previews: some View {
        EditarRecebidos(recebidos: Recebidos())
    }
}
