//
//  RecebidosListaView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI
import CoreData

struct RecebidosListaView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity:Recebidos.entity(),sortDescriptors:[NSSortDescriptor(keyPath: \Recebidos.data, ascending: false)])
    var recebidos:FetchedResults<Recebidos>
    
    var soma: Double {
        recebidos.reduce(0) { $0 + $1.valor}
    }
    
    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor){
        let fetchRequest = NSFetchRequest<Recebidos>(entityName: Recebidos.entity().name ?? "Recebidos")
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        _recebidos = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
    
            VStack{
                if !(soma <= 0){
                    
                List{
                    ForEach(recebidos, id:\.self){ recebido in
                        
                        VStack(alignment:.leading){
                            NavigationLink(destination:DetalheRecebidos(recebidos: recebido)){
                                Text(recebido.nome ?? "")
                             }
                            Text("R$ \(recebido.valor,specifier: "%.2f")")
                            Spacer()
                                
                        }
                        
                    }.onDelete(perform: delete)
                    
                    
                }
           
                    
                    Spacer()
                    
                
                    VStack{
                        HStack(alignment:.center){
                            Text("Total")
                                .padding()
                            Text("R$ \(soma,specifier: "%.2f")")
                                .padding()
                            
//                                Image("cofrinho")
//                                    .resizable()
//                                    .frame(width:70,height:50)
//                                    .animation(.none)
                        }
                        .font(.headline)
                        .padding(.bottom,5)
                        .padding(.top,30)
                    }
            }
            if recebidos.count <= 0 {
                    VStack(alignment: .leading){
                        Spacer()
                        Text("Sem dados de recebidos.")
                        Text("Por favor insira um novo recebido clicando no botão + ")
                        Spacer()
                    }
                        
                }
                
            }
            .background(Color.white.opacity(0.15))
            
        }
    
    
    // MARK :- Metodos
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let recebido = recebidos[offset]
            moc.delete(recebido)
        }
        // save the context
        try? moc.save()
    }
    
}
struct RecebidosListaView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(modelName: "Recebidos")
        let sortDescriptor = RecebidosSort(sortType: .data, sortOrder: .descending).sortDescriptor
       return RecebidosListaView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}
