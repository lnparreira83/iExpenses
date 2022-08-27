//
//  ContentView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity:Despesas.entity(),sortDescriptors:[]) var despesas:FetchedResults<Despesas>
    
    @State private var mostrarAdicionaDespesa = false
    @State private var searchText = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.data
    @State private var sortOrder = SortOrder.descending
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Pesquisar despesas")
                        .frame(height:35)
                        .padding()
                    .onTapGesture {
                        self.endEditing()
                    }
                
                    SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
                        .frame(height:35)
                    
                    DespesasListView(predicate: Despesas.predicate(with: searchText), sortDescriptor: DespesasSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
                    
                }
                .background(Color.gray.opacity(0.10))
                .border(Color.black, width: 0.2)
                .cornerRadius(12)
                .shadow(color: .blue, radius: 6, x: 0, y: 0)
                .navigationBarTitle("iExpenses",displayMode: .inline).font(.headline)
                .navigationBarItems(trailing: Button(action:{
                    self.mostrarAdicionaDespesa = true
                }){
                    CircleButtonView(iconName: "plus")
                        .background(CircleButtonAnimationView(animate: $mostrarAdicionaDespesa))
                  }
                )
                .sheet(isPresented: $mostrarAdicionaDespesa){
                    AdicionaDespesas()
                }
            }
        
            
        }
    
    func endEditing(){
        UIApplication.shared.endEditing()
        searchText = ""
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
