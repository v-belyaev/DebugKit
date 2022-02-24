//
//  DebugModule.swift
//  
//
//  Created by Владимир Беляев on 22.02.2022.
//

import Foundation

enum DebugModule: Int, CustomStringConvertible {
  case fakeTouch = 0
  
  var description: String {
    switch self {
    case .fakeTouch:
      return "Fake touch"
    }
  }
}
