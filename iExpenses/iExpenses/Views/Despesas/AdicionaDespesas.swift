//
//  AdicionaDespesas.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//

import SwiftUI
import CoreData

struct AdicionaDespesas: View {
    //@StateObject var despesas:Despesas
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var mostrarDetalhesDespesas = false
    //@State private var despesaItem: Despesas = Despesas()
    @State var nomeDespesa = ""
    @State var tipoDespesa = "Semanal"
    @State var valorDespesa = "0.0"
    @State var dataDespesa = Date()
    static let tipo = ["Semanal","Quinzenal","Mensal"]
    
    
    
    var body: some View {
        VStack{
            NavigationView{
                Form{
                    Text("Adicionar despesa")
                        .font(.headline)
                    TextField("Nome da despesa : ",text:$nomeDespesa)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Picker("Periocidicade",selection: $tipoDespesa){
                        ForEach(Self.tipo, id:\.self){
                            Text("\($0)")
                        }
                    }
                    TextField("Valor da despesa : ",text:$valorDespesa).keyboardType(.numberPad)
                    //TextField("Data da despesa :",text:$dataDespesa)
                        .keyboardType(.default)
                    DatePicker("Data da despesa : ",selection:$dataDespesa,displayedComponents:.date)
                    
                }
                .navigationBarItems(leading: Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }, label:{
                        Text("Cancel")
                    }),
                trailing: Button("Save"){
                    let novaDespesa = Despesas(context: self.moc)
                    novaDespesa.nome = self.nomeDespesa
                    novaDespesa.tipo = self.tipoDespesa
                    novaDespesa.valor = Double(valorDespesa) ?? 0.0
                    novaDespesa.timeStamp = self.dataDespesa
                    
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            
        }
        
    }
}

struct AdicionaDespesas_Previews: PreviewProvider {
    static var previews: some View {
        AdicionaDespesas()
    }
}
