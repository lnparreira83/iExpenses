//
//  AdicionaRecebidos.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI
import CoreData

struct AdicionaRecebidos: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var mostrarDetalhesDespesas = false
    @State var nomeRecebido = ""
    @State var valorRecebido = ""
    @State var dataRecebido = Date()
    
    
    
    var body: some View {
        VStack{
            NavigationView{
                Form{
                    Text("Adicionar recebido")
                        .font(.headline)
                    TextField("Nome do recebido : ",text:$nomeRecebido)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Valor do recebido : R$ 0.00 ",text:$valorRecebido).keyboardType(.decimalPad)
                        .keyboardType(.default)
                    DatePicker("Data da despesa : ",selection:$dataRecebido,displayedComponents:.date)
                    
                }
                .navigationBarItems(leading: Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }, label:{
                        Text("Cancel")
                    }),
                trailing: Button("Save"){
                    let novoRecebido = Recebidos(context: self.moc)
                    novoRecebido.nome = self.nomeRecebido
                    novoRecebido.valor = Double(valorRecebido) ?? 0.0
                    novoRecebido.data = self.dataRecebido
                    
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            
        }
        
    }
}


struct AdicionaRecebidos_Previews: PreviewProvider {
    static var previews: some View {
        AdicionaRecebidos()
    }
}
