//
//  iExpensesTests.swift
//  iExpensesTests
//
//  Created by Lucas Parreira on 25/08/22.
//

import XCTest
import SwiftUI
import CoreData

class iExpensesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdicionaDespesas() throws {
        @Environment(\.managedObjectContext) var moc
        @Environment(\.presentationMode) var presentationMode
        
        class Despesas {
            var id = UUID();
            var nome : String;
            var data : String;
            var tipo : String;
            var valor : Double;
            
            init(id : UUID, nome : String = "Lucas", data : String = "28/12/2022", tipo : String = "Mensal", valor : Double = 25.02) {
                self.id = id;
                self.nome = nome;
                self.data = data;
                self.tipo = tipo;
                self.valor = valor;
            }
        }
        
//        let novaDespesa : Despesas;
//        novaDespesa.nome = "Lucas"
//        novaDespesa.tipo = "Mensal"
//        let valorDespesa = 17.23
//        novaDespesa.valor = valorDespesa ?? 0.0
        //novaDespesa.timeStamp = self.dataDespesa
        
        
        //assert(!novaDespesa.nome.isEmpty)
        
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
