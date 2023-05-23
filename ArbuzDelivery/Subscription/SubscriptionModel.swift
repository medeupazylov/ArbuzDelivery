//
//  SubscriptionModel.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 23.05.2023.
//

import UIKit

protocol SubscriptionModelProtocol {
    var subscriptions: [SubscriptModel] { get set }
    
    mutating func addSubscription(subscription: SubscriptModel)
}

struct SubscriptionModel: SubscriptionModelProtocol {
    
    var subscriptions: [SubscriptModel] = []
    
    mutating func addSubscription(subscription: SubscriptModel) {
        subscriptions.append(subscription)
    }
    
}
