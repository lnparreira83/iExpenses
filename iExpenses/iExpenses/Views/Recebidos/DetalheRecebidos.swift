//
//  DetalheRecebidos.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI

struct DetalheRecebidos: View {
    let recebidos:Recebidos
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var mostrarAlertaDeletar = false
    
    var body: some View {
        NavigationView{
            List{
                Text("Detalhe do recebido")
                    .font(.headline)
                NavigationLink(destination:EditarRecebidos(recebidos: recebidos)){
                    Text(self.recebidos.nome ?? "Nome desconhecido").font(.headline)
                }
                
                Text("R$ \(recebidos.valor,specifier: "%.2f")")
                Text("\(recebidos.data ?? Date() ) ")
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
        moc.delete(recebidos)
         try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
   
}

struct DetalheRecebidos_Previews: PreviewProvider {
    static var previews: some View {
        DetalheRecebidos(recebidos: Recebidos())
    }
}
