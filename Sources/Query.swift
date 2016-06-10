//
//  Query.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 01/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

/** Contains the complete GraphQL query and creates a String representation that can be read by GraphQL
 
 ***Example usage:***
 ```swift
 let request = RequestObject(withRequest: Request(
 name: "queryName",
 arguments: [
 Argument(key: "argument", values: [argumentValue1, argumentValue2])
 ],
 fields: [
 "fieldName",
 "fieldName",
 Request(
 name: "fieldName",
 arguments: [
 Argument(key: "argument", value: "argumentValue")
 ],
 fields: [
 "fieldName"
 ]
 )
 ]
 ))
 ```
 */
public struct Query: Operation {
  private let alias: String
  private let requests: [Request]
  private let fragments: [Fragment]
  private let queryType: QueryType
  
  public init(withAlias alias: String = "", readingRequest request: ReadingRequest, fragments: [Fragment] = []) {
    self.init(withAlias: alias, readingRequests: [request], fragments: fragments)
  }
  
  public init(withAlias alias: String = "", readingRequests requests: [ReadingRequest], fragments: [Fragment] = []) {
    self.alias = alias
    self.requests = requests.map {$0}
    self.fragments = fragments
    self.queryType = .Query
  }
  
  private var queryName: String? {
    return  alias.isEmpty == false ? "query \(alias)" : nil
  }
  
  public func create() -> String {
    let query = "{\(requests.map{$0.asGraphQLString}.joinWithSeparator(""))}\(fragments.map {$0.asGraphQLString}.joinWithSeparator(""))"
    return [queryName, query].flatMap { $0 }.joinWithSeparator(" ")
  }
}

extension Query {
  public var debugDescription: String {
    let query = "{\n\t\(requests.map{$0.debugDescription}.joinWithSeparator("\n"))\n}\n\(fragments.map {$0.debugDescription}.joinWithSeparator(""))"
    return "\n\([queryName, query].flatMap { $0 }.joinWithSeparator(" "))\n"
  }
}