//
//  RecebidosHomeView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI

struct RecebidosHomeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity:Recebidos.entity(),sortDescriptors:[]) var recebidos:FetchedResults<Recebidos>
    
    @State private var mostrarAdicionaRecebido = false
    @State private var searchText = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.data
    @State private var sortOrder = SortOrder.descending
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Pesquisar recebidos")
                        .frame(height:35)
                        .padding()
                    .onTapGesture {
                        self.endEditing()
                    }
                
                    SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
                        .frame(height:35)
                    
                    RecebidosListaView(predicate: Recebidos.predicate(with: searchText), sortDescriptor: RecebidosSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
                    
                }
                .background(Color.gray.opacity(0.10))
                .border(Color.black, width: 0.2)
                .cornerRadius(12)
                .shadow(color: .blue, radius: 8, x: 0, y: 0)
                .navigationBarTitle("iExpenses",displayMode: .inline).font(.headline)
                .navigationBarItems(trailing: Button(action:{
                    self.mostrarAdicionaRecebido = true
                }){
                    CircleButtonView(iconName: "plus")
                        .background(CircleButtonAnimationView(animate: $mostrarAdicionaRecebido))
                  }
                )
                .sheet(isPresented: $mostrarAdicionaRecebido){
                    AdicionaRecebidos()
                }
                
            }
        
            
        }
    
    func endEditing(){
        UIApplication.shared.endEditing()
        searchText = ""
    }
    
}

struct RecebidosHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RecebidosHomeView()
    }
}

