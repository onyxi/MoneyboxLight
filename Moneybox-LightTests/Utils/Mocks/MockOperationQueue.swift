//
//  MockOperationQueue.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation
@testable import Moneybox_Light

public class MockOperationQueue: OperationQueue {

  public var lastCapturedOperation: Operation?
  public var capturedOperations = [Operation]()
  
  public override func addOperation(_ operation: Operation) {
    super.addOperation(operation)
    lastCapturedOperation = operation
    capturedOperations.append(operation)
  }
  
}
