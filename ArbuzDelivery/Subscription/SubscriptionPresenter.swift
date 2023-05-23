//
//  SubscriptionPresenter.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 23.05.2023.
//

import UIKit

protocol SubscriptionViewProtocol: AnyObject {
    
}

protocol SubscriptionPresenterProtocol {
    func addToSubscriptions(subscription: SubscriptModel)
    func getSubscriptions() -> [SubscriptModel]
}

class SubscriptonPresenter: SubscriptionPresenterProtocol {
    func getSubscriptions() -> [SubscriptModel] {
        return subscriptionModel.subscriptions
    }
    
    
    var subscriptionModel: SubscriptionModelProtocol
    weak var subscriptionView: SubscriptionViewProtocol?
    weak var tabConnector: TabBarConnectorProtocol?
    
    init(newSubscriptionModel: SubscriptionModelProtocol) {
        subscriptionModel = newSubscriptionModel
    }
    
    func addToSubscriptions(subscription: SubscriptModel) {
        subscriptionModel.addSubscription(subscription: subscription)
        print("Added new subscription")
        print(subscriptionModel.subscriptions)
    }
}
