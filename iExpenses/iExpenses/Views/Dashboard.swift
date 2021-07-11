//
//  ResumoHomeView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI

struct Dashboard: View {
    @FetchRequest(entity:Despesas.entity(),sortDescriptors:[])
    var despesas:FetchedResults<Despesas>
    
    @FetchRequest(entity:Recebidos.entity(),sortDescriptors:[])
    var recebidos:FetchedResults<Recebidos>
    
    var somaDespesas: Double {
        despesas.reduce(0) { $0 + $1.valor}
    }
    
    var somaRecebidos: Double {
        recebidos.reduce(0) { $0 + $1.valor}
    }
    
    var body: some View {
        NavigationView{
            
                VStack{
                    
                    Text("Recebidos: R$ \(somaRecebidos,specifier: "%.2f")")
                        .font(.custom("Arial", size: 25, relativeTo: .headline))
                        .frame(width:330,height:75)
                        .background(Color.gray.opacity(0.10))
                        .border(Color.black, width: 0.3)
                        .cornerRadius(12)
                        .shadow(color: .green, radius: 8, x: 0, y: 0)
                        .padding(.bottom,5)
                        
                    
                    Text("Despesas: R$ \(somaDespesas,specifier: "%.2f")")
                        .font(.custom("Arial", size: 25, relativeTo: .headline))
                        .frame(width:330,height:75)
                        .background(Color.gray.opacity(0.10))
                        .border(Color.black, width: 0.3)
                        .cornerRadius(12)
                        .shadow(color: .green, radius: 8, x: 0, y: 0)
                        .padding(.bottom,5)
                        
                    
                    if (somaRecebidos - somaDespesas) < 0 {
                        Text("Balanço atual: R$ \(somaRecebidos - somaDespesas,specifier: "%.2f")")
                            .font(.custom("Arial", size: 25, relativeTo: .headline))
                            .frame(width:330,height:75)
                            .background(Color.red.opacity(0.10))
                            .border(Color.black, width: 0.3)
                            .cornerRadius(12)
                            .shadow(color: .black, radius: 8, x: 0, y: 0)
                            .padding(.top,5)
                            
                        
                    } else {
                        Text("Balanço atual: R$ \(somaRecebidos - somaDespesas,specifier: "%.2f")")
                            .font(.custom("Arial", size: 25, relativeTo: .headline))
                            .frame(width:330,height:75)
                            .background(Color.gray.opacity(0.10))
                            .border(Color.black, width: 0.3)
                            .cornerRadius(12)
                            .shadow(color: .green, radius: 8, x: 0, y: 0)
                            .padding(.top,5)
                            
                    }
            }
            .navigationBarTitle("iExpenses",displayMode: .inline)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
