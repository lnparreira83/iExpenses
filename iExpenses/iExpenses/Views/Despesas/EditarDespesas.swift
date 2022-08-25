//
//  EditarDespesas.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//

import SwiftUI

struct EditarDespesas: View {
    let despesas : Despesas
    @State var nomeDespesa = ""
    @State var tipoDespesa = "Mensal"
    @State var valorDespesa = ""
    @State var dataDespesa = Date()
    
    static let tipo = ["Semanal","Quinzenal","Mensal"]
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            Form{
                Text("Editar despesa")
                    .font(.headline)
                TextField(despesas.nome ?? "" ,text:$nomeDespesa)
                Picker("Periocidicade",selection: $tipoDespesa){
                    ForEach(Self.tipo, id:\.self){
                        Text("\($0)")
                    }
                }
                TextField("Valor" ,text:$valorDespesa).keyboardType(.decimalPad)

                DatePicker("Data da despesa : ",selection:$dataDespesa,displayedComponents:.date)
                
                Button("atualizar"){
                    
                    if !(nomeDespesa.isEmpty) {
                        despesas.nome = self.nomeDespesa
                    }
                    
                    if !(tipoDespesa.isEmpty) {
                        despesas.tipo = self.tipoDespesa
                    }
                    
                    if !(valorDespesa.isEmpty && Double(valorDespesa) ?? 0.0 > 0) {
                        despesas.valor = Double(valorDespesa) ?? 0.0
                    }
                    
                    despesas.timeStamp = dataDespesa
                    
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                .frame(width:300,height:40)
                .cornerRadius(12)
                .foregroundColor(.white)
                .background(Color.blue)
                
            }
//            .background(Color.blue.opacity(0.20))
//                .foregroundColor(.blue)
//                .border(Color.black, width: 0.3)
//                .cornerRadius(8)
//                .shadow(color: .blue, radius: 8, x: 0, y: 0)
        }
    }
}

struct EditarDespesas_Previews: PreviewProvider {
    static var previews: some View {
        EditarDespesas(despesas: Despesas())
    }
}
