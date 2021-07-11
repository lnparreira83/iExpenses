//
//  HomeView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(entity:Despesas.entity(),sortDescriptors:[]) var despesas:FetchedResults<Despesas>
    
    var body: some View {
        TabView{
            Dashboard()
                .tabItem {
                    Image(systemName: "house")
                    Text("Resumo")
            }
            Spacer()
            ContentView()
                .tabItem {
                    Image(systemName: "bitcoinsign.circle")
                    Text("Despesas")
            }
            Spacer()
            RecebidosHomeView()
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Recebidos")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
