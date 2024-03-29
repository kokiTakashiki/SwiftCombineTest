//
//  BaseStoreFlowableFactory.swift
//  StoreFlowable
//
//  Created by tamura_k on 2021/07/20.
//

import Foundation
import Combine

/**
 * Common function of `StoreFlowableFactory`, `PaginationStoreFlowableFactory`, `TwoWayPaginationStoreFlowableFactory` protocols.
 */
public protocol BaseStoreFlowableFactory {

    /**
     * Specify the type that is the key to retrieve the data. If there is only one data to handle, specify the `UnitHash` type.
     */
    associatedtype KEY: Hashable
    /**
     * Specify the type of data to be handled.
     */
    associatedtype DATA

    /**
     * Key to which data to get.
     *
     * Please implement so that you can pass the key from the outside.
     */
    var key: KEY { get }

    /**
     * Used for data state management.
     *
     * Create a class that inherits `FlowableDataStateManager` and assign it.
     */
    //var flowableDataStateManager: FlowableDataStateManager<KEY> { get }

    /**
     * The data loading process from cache.
     *
     * - returns: The loaded data.
     */
    //func loadDataFromCache() -> AnyPublisher<DATA?, Never>

    /**
     * The data saving process to cache.
     *
     * - parameter newData: Data to be saved.
     */
    //func saveDataToCache(newData: DATA?) -> AnyPublisher<Void, Never>

    /**
     * Determine if the cache is valid.
     *
     * - parameter cachedData: Current cache data.
     * - returns: Returns `true` if the cache is invalid and refresh is needed.
     */
    //func needRefresh(cachedData: DATA) -> AnyPublisher<Bool, Never>
}
