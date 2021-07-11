//
//  DetalheDespesas.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//
import SwiftUI
import CoreData
import UIKit

struct DetalheDespesas: View {
    let despesas:Despesas
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var mostrarAlertaDeletar = false
    
//    static let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        #if os(watchOS)
//        formatter.dateFormat = "dd/MM"
//        #else
//        formatter.dateFormat = "dd/MM/yyyy"
//        #endif
//        return formatter
//    }()
    
    
    var body: some View {
        NavigationView{
            List{
                Text("Detalhe da despesa")
                    .font(.headline)
                NavigationLink(destination:EditarDespesas(despesas: despesas)){
                    Text(self.despesas.nome ?? "Nome desconhecido").font(.headline)
                }
                
                Text(self.despesas.tipo ?? "Tipo desconhecido")
                Text("R$ \(despesas.valor,specifier: "%.2f")")
                Text("\(despesas.timeStamp ?? Date() ) ")
            }
            .padding()
            .navigationBarHidden(true)
            .alert(isPresented:$mostrarAlertaDeletar){
                Alert(title: Text("Deletar despesa"),message: Text("Tem certeza"),primaryButton: .destructive(Text("Deletar")){
                    self.delete()
                },
                secondaryButton: .cancel())
            }
            .navigationBarItems(
                trailing: Button(action:{
                self.mostrarAlertaDeletar = true
            }){
                Image(systemName: "trash")
            })
          }
            
        }
    
    
    // MARK:- Metodos
    func delete() {
        moc.delete(despesas)
         try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
   
}

struct DetalheDespesas_Previews: PreviewProvider {
    static var previews: some View {
        DetalheDespesas(despesas: Despesas())
    }
}
