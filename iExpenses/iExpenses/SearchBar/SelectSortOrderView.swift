//
//  SelectSortOrderView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 10/07/21.
//

import SwiftUI

enum SortType: String, CaseIterable {
    case data
    case valor
    case nome
}

enum SortOrder: String, CaseIterable {
    case ascending
    case descending
}

extension SortType: Identifiable {
    var id: String { rawValue }
}

extension SortOrder: Identifiable {
    var id: String { rawValue }
}

struct DespesasSort {
    var sortType: SortType
    var sortOrder: SortOrder
    
    var isAscending: Bool {
        sortOrder == .ascending ? true : false
    }
    
    var sortDescriptor: NSSortDescriptor {
        switch sortType {
        case .nome:
            return NSSortDescriptor(keyPath: \Despesas.nome, ascending: isAscending)
        case .data:
            return NSSortDescriptor(keyPath: \Despesas.data, ascending: isAscending)
        case .valor:
            return NSSortDescriptor(keyPath: \Despesas.valor, ascending: isAscending)
        }
    }
}

struct RecebidosSort {
    var sortType: SortType
    var sortOrder: SortOrder
    
    var isAscending: Bool {
        sortOrder == .ascending ? true : false
    }
    
    var sortDescriptor: NSSortDescriptor {
        switch sortType {
        case .nome:
            return NSSortDescriptor(keyPath: \Despesas.nome, ascending: isAscending)
        case .data:
            return NSSortDescriptor(keyPath: \Despesas.data, ascending: isAscending)
        case .valor:
            return NSSortDescriptor(keyPath: \Despesas.valor, ascending: isAscending)
        }
    }
}

struct SelectSortOrderView: View {
    
    @Binding var sortType: SortType
    @Binding var sortOrder: SortOrder
    
    private let sortTypes = SortType.allCases
    private let sortOrders = SortOrder.allCases
    
    func systemNameImage(sortType: SortType) -> String {
        switch sortType {
        case .valor: return "dollarsign.circle"
        case .data: return "calendar"
        case .nome: return "a"
        }
    }
    
    var body: some View {
        HStack {
            Text("Sort by")
            Picker(selection: $sortType, label: Text("Sort by")) {
                ForEach(SortType.allCases) { type in
                    Image(systemName: self.systemNameImage(sortType: type))
                        .tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Order by")
            Picker(selection: $sortOrder, label: Text("Order")) {
                ForEach(sortOrders) { order in
                    Image(systemName: order == .ascending ? "arrow.up" : "arrow.down")
                        .tag(order)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.all)
        .frame(height: 64)
        
    }
}

struct SelectSortOrderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSortOrderView(sortType: .constant(.valor), sortOrder: .constant(.descending))
    }
}
