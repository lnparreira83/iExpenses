//
//  DespesasListView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 10/07/21.
//

import SwiftUI
import CoreData

struct DespesasListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity:Despesas.entity(),sortDescriptors:[NSSortDescriptor(keyPath: \Despesas.data, ascending: false)]) var despesas:FetchedResults<Despesas>
    
    var soma: Double {
        Double(despesas.reduce(0) { $0 + $1.valor})
    }
    
    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor){
        let fetchRequest = NSFetchRequest<Despesas>(entityName: Despesas.entity().name ?? "Despesas")
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        _despesas = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
    
            VStack{
                if !(soma <= 0){
                    
                List{
                    ForEach(despesas, id:\.self){ despesa in
                        
                        VStack(alignment:.leading){
                           NavigationLink(destination:DetalheDespesas(despesas: despesa)){
                                Text(despesa.nome ?? "")
                             }
                            Text("R$ \(despesa.valor,specifier: "%.2f")")
                            Spacer()
                                
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
                    Spacer()
                    
                    VStack{
                        HStack(alignment:.center){
                            Text("Total")
                                .padding()
                            Text("R$ \(soma,specifier: "%.2f")")
                                .padding()
                            
//                                Image("money")
//                                    .resizable()
//                                    .frame(width:70,height:50)
//                                    .animation(.none)
                        }
                        .font(.headline)
                        .padding(.bottom,5)
                        .padding(.top,30)
                    }
                    
                }
                if despesas.count <= 0 {
                    VStack(alignment: .leading){
                        Spacer()
                        Text("Sem dados de despesas.")
                        Text("Por favor insira uma nova despesa clicando no botão + ")
                        Spacer()
                    }
                        
                }
                
            }
            .background(Color.white.opacity(0.15))
            
        }
    
    // MARK :- Metodos
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let despesa = despesas[offset]
            moc.delete(despesa)
        }
        // save the context
        try? moc.save()
    }
    
}
struct DespesasListView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(modelName: "Despesas")
        let sortDescriptor = DespesasSort(sortType: .data, sortOrder: .descending).sortDescriptor
        return DespesasListView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}
