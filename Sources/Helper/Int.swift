//
//  Int.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 07/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

import Foundation

extension Int: Field {
  public var asGraphQLString: String {
    return description
  }
}

extension Int: ArgumentValue {
  public var asGraphQLArgument: String {
    return asGraphQLString
  }
}