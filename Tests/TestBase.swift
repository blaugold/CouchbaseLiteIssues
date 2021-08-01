//
//  Utils.swift
//  Tests
//
//  Created by Gabriel Terwesten on 01.08.21.
//

import XCTest
import CouchbaseLiteSwift

class TestBase : XCTestCase {
    private static var evalExprDb: Database?

    private class func setupEvalExprDb() {
        if evalExprDb != nil {
            return
        }
        
        let dbName = "EvalExpr"
        let config = DatabaseConfiguration()
        config.directory = FileManager.default.currentDirectoryPath
        
        if Database.exists(withName: dbName, inDirectory: config.directory) {
            try! Database.delete(withName: dbName, inDirectory: config.directory)
        }
        
        evalExprDb = try! Database(name: dbName, config: config)
        try! evalExprDb!.saveDocument(MutableDocument())
    }
    
    override class func setUp() {
        setupEvalExprDb()
    }
    
    override class func tearDown() {
        try! evalExprDb?.close()
    }

    func evalExpr(_ expression: ExpressionProtocol) -> Fragment {
        let query = QueryBuilder
            .select(SelectResult.expression(expression))
            .from(DataSource.database(TestBase.evalExprDb!))
        print(try! query.explain())
        return try! query.execute().next()![0]
    }
}
