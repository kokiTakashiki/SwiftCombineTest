//
//  LoadingStatePublisher.swift
//  CombineTestStoryBoard
//
//  Created by 武田孝騎 on 2021/11/24.
//

import Foundation
import Combine

/**
 * Type alias of `AnyPublisher<LoadingState<DATA>, Never>`.
 */
public typealias LoadingStatePublisher<DATA> = AnyPublisher<LoadingState<DATA>, Error>
