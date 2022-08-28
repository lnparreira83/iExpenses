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
        
        struct Despesas {
            var id = UUID();
            var nome : String = "Aluguel";
            var data : String = "28/08/2022";
            var tipo : String = "Mensal";
            var valor : Double = 1000.99;
        }
        
        let data = Despesas()
        XCTAssertEqual(data.nome.isEmpty, false)
        XCTAssertEqual(data.data.isEmpty, false)
        XCTAssertEqual(data.tipo.isEmpty, false)
        XCTAssertEqual(data.valor.isZero, false)
    }
    
    func testAdicionaRecebidos() throws {
        
        struct Recebidos {
            var id = UUID();
            var nome : String = "Aluguel";
            var data : String = "28/08/2022";
            var tipo : String = "Mensal";
            var valor : Double = 1000.99;
        }
        
        let data = Recebidos()
        XCTAssertEqual(data.nome.isEmpty, false)
        XCTAssertEqual(data.data.isEmpty, false)
        XCTAssertEqual(data.tipo.isEmpty, false)
        XCTAssertEqual(data.valor.isZero, false)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
