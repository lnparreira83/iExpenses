//
//  DespesasExtension.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//

import Foundation
import CoreData

extension Despesas {
    static func predicate(with searchText: String) -> NSPredicate? {
        var predicates = [NSPredicate]()
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "nome CONTAINS[cd] %@", searchText.lowercased()))
        }
        
        if predicates.isEmpty {
            return nil
        } else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }
    
    var shareContent: String {
        "Despesa \(nome ?? "")(\(tipo ?? "")) em \(data ?? "") com valor de \(valor)"
    }
    
    var csvString: String {
        "\(nome ?? "") ,\(data ?? "") , \(tipo ?? "") , \(valor)"
    }
}
