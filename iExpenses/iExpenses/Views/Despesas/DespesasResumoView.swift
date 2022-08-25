//
//  DespesasResumoView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 10/07/21.
//

import SwiftUI

struct DespesasResumoView: View {
    
    @FetchRequest(entity:Despesas.entity(),sortDescriptors:[NSSortDescriptor(keyPath: \Despesas.data, ascending: false)]) var despesas:FetchedResults<Despesas>
    
    var soma: Double {
        Double(despesas.reduce(0) { $0 + $1.valor})
    }
    
    var body: some View {
        VStack(alignment:.center){
            List{
                Text("Resumo de despesas")
                    .font(.system(size: 25)).bold()
                HStack{
                    Text("Nome da despesa").font(.headline)
                    Spacer()
                    Text("Valor").font(.headline)
                }
                .padding()
                
            if !(soma <= 0){
                ForEach(despesas, id:\.self){ despesa in
                    VStack(alignment:.leading){
                        HStack{
                                Text(despesa.nome ?? "")
                                Spacer()
                                Text("R$ \(despesa.valor,specifier: "%.2f")")
                        }
                        .padding()
                      }
                   }
            } else {
                   Spacer()
                   VStack(alignment:.leading){
                       Text("Sem dados de despesas.")
                       Text("Por favor insira uma nova despesa clicando no primeiro botão no menu abaixo, e em seguida clicando no botão +")
                       Spacer()
                   }
               }
            }
            
            Spacer()

            VStack{
                
                HStack(alignment:.center){
                    
                    Text("Total")
                        .padding()
                    Text("R$ \(soma,specifier: "%.2f")")
                        .padding()
                    if despesas.count > 0 {
                        Image("money")
                            .resizable()
                            .frame(width:70,height:50)
                    }
                }
                .font(.headline)
                .padding(.bottom,5)
        }
    }
  }
}

struct DespesasResumoView_Previews: PreviewProvider {
    static var previews: some View {
        DespesasResumoView()
    }
}
