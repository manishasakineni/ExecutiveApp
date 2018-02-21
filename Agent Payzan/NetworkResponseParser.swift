//
//  NetworkResponseParser.swift
//  Networking
//
//  Created by Sateesh Y on 30/11/16.
//  Copyright © 2016 Sateesh Y. All rights reserved.
//

import UIKit

class NetworkResponseParser: NSObject {
    
    
    /*
    
    static let sharedInstance = NetworkResponseParser()
    
    //MARK: - Prase Login Response
    
    func parseLoginResponse(_ object: AnyObject?) -> LoginModel {
        
        var loginModel = LoginModel()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                loginModel = LoginModel.init(dict: response)
            }
        }
        
        return loginModel
    }
    
    
    //MARK: - Parse forgot password response
    
    func parseforgotPasswordResponse(object: AnyObject?) -> String {
        
        var status = ""
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let statusMessage = response["statusMessage"]
                
                if Utilities.sharedInstance.isObjectNull(statusMessage as AnyObject?) {
                    
                    if let response = statusMessage as? NSString {
                        
                        status = response as String
                    }
                }
            }
        }
        
        return status
    }
    
    func parseCategories(object: AnyObject?) -> Array<CategoriesModel> {
        
        var categories = Array<CategoriesModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let responseArray = response["data"]
                
                if let response = responseArray as? NSArray {
                    
                    if Utilities.sharedInstance.isObjectNull(response) {
                        
                        for data in response {
                            
                            if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                                
                                if let category = data as? NSDictionary {
                                    
                                    let categoryModel = CategoriesModel(dict: category)
                                    
                                    if Utilities.sharedInstance.isObjectNull(category["subCategories"] as AnyObject?) {
                                        
                                        if let newArray = category["subCategories"] {
                                            
                                            if let subCategoriesArray = newArray as? NSArray {
                                                
                                                var subCategories = Array<CategoriesModel>()
                                                
                                                for subCategoryObject in subCategoriesArray {
                                                    
                                                    if let subCategory = subCategoryObject as? NSDictionary {
                                                        
                                                        let subCategoryModel = CategoriesModel(dict: subCategory)
                                                        
                                                        if Utilities.sharedInstance.isObjectNull(subCategory["groups"] as AnyObject?) {
                                                            
                                                            if let groupObject = subCategory["groups"] {
                                                                
                                                                if let groupArray = groupObject as? NSArray {
                                                                    
                                                                    var groups = Array<CategoriesModel>()
                                                                    
                                                                    for groupObject in groupArray {
                                                                        
                                                                        if let group = groupObject as? NSDictionary {
                                                                            
                                                                            let groupModel = CategoriesModel(dict: group)
                                                                            groups.append(groupModel)
                                                                        }
                                                                    }
                                                                    
                                                                    subCategoryModel.groups = groups
                                                                }
                                                            }
                                                        }
                                                        
                                                        subCategories.append(subCategoryModel)
                                                    }
                                                }
                                                
                                                categoryModel.subCategories = subCategories
                                            }
                                        }
                                    }
                                    
                                    categories.append(categoryModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        return categories
    }
    
    //MARK: - Parse Group
    func parseGroup(object: AnyObject?) -> Array<ItemDetailsModel> {
        
        var itemDetails = Array<ItemDetailsModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for itemGroup in response {
                                
                                if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
                                    
                                    let itemDetailsModel = ItemDetailsModel(dict: itemGroup as? NSDictionary)
                                    itemDetails.append(itemDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return itemDetails
    }
    
    //MARK: - Parse Category's List
    
    func parseListCategories(object: AnyObject?) -> Array<CompleteOrderModel> {
        
        var completeDetails = Array<CompleteOrderModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for itemGroup in response {
                                
                                if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
                                    
                                    let itemDetailsModel = CompleteOrderModel(dict: itemGroup as? NSDictionary)
                                    completeDetails.append(itemDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return completeDetails
    }
    
    //MARK: - Prase Customer Order Item Details
    
    func parseTotalOrderDetails(object: AnyObject?) -> Array<TotalOrdersModel> {
        
        var orderDetails = Array<TotalOrdersModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["totals"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for orderDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
                                    
                                    let totalOrderDetailsModel = TotalOrdersModel(dict: orderDetail as? NSDictionary)
                                    orderDetails.append(totalOrderDetailsModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return orderDetails
    }
    
//MARK: - Parse SimilarItemDetail

    func parseSimilarItemDetailsArray(object: AnyObject?) -> Array<SimilarItemModel> {
        
        var similaritemDetails = Array<SimilarItemModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for itemGroup in response {
                                
                                if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
                                    
                                    let similaritemDetailsModel = SimilarItemModel(dict: itemGroup as? NSDictionary)
                                    similaritemDetails.append(similaritemDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return similaritemDetails
    }
    
    
    func parseBestSimilarItemDetailsArray(object: AnyObject?) -> Array<SimilarItemModel> {
        
        var similaritemDetails = Array<SimilarItemModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["bestSellingItems"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for itemGroup in response {
                                
                                if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
                                    
                                    let similaritemDetailsModel = SimilarItemModel(dict: itemGroup as? NSDictionary)
                                    similaritemDetails.append(similaritemDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return similaritemDetails
    }
    //MARK: - Parse OpenOrderDetail
    
    func parseOpenItemDetailsArray(object: AnyObject?) -> Array<OpenOrderModel> {
        
        var openItemDetails = Array<OpenOrderModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for itemGroup in response {
                                
                                if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
                                    
                                    let openItemDetailsModel = OpenOrderModel(dict: itemGroup as? NSDictionary)
                                    openItemDetails.append(openItemDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return openItemDetails
    }
    
    
    func parseCollectionItemDetailsArray(object: AnyObject?) -> Array<Dictionary<String,Any>> {
        
        var collectionitemDetails = Array<Dictionary<String,Any>>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for itemGroup in response {
                                
                                if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
                                    
                                    let collectionitemDetail =  itemGroup as? Dictionary<String,Any>
                                    collectionitemDetails.append(collectionitemDetail!)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return collectionitemDetails
    }
    
    //MARK: - Parse CountInfo
    func parseCountInfo(object: AnyObject?) -> Array<CountModel> {
        
        var countInfo = Array<CountModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for countDetails in response {
                                
                                if Utilities.sharedInstance.isObjectNull(countDetails as AnyObject?) {
                                    
                                    let countDetailsModel = CountModel(dict: countDetails as? NSDictionary)
                                    countInfo.append(countDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return countInfo
    }
    
    //MARK: - Prase Freight Terms
    
    func parseFreightTypes(object: AnyObject?) -> Array<FreightTermsModel> {
        
        var frieghtTerms = Array<FreightTermsModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for freightDetails in response {
                                
                                if Utilities.sharedInstance.isObjectNull(freightDetails as AnyObject?) {
                                    
                                    let countDetailsModel = FreightTermsModel(dict: freightDetails as? NSDictionary)
                                    frieghtTerms.append(countDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return frieghtTerms
    }
    
    
    //MARK: - Prase Payment Terms
    
    func parsePaymentTypes(object: AnyObject?) -> Array<PaymentTermsModel> {
        
        var paymentTerms = Array<PaymentTermsModel>()
        
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for paymentDetails in response {
                                
                                if Utilities.sharedInstance.isObjectNull(paymentDetails as AnyObject?) {
                                    
                                    let countDetailsModel = PaymentTermsModel(dict: paymentDetails as? NSDictionary)
                                    paymentTerms.append(countDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return paymentTerms
    }
    
    //MARK: - Parse OrderSummary
    
    func parseOrderSummary(object: AnyObject?) -> Array<OrderSummaryModel> {
        
        var orderSummaryDetails = Array<OrderSummaryModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for summaryDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(summaryDetail as AnyObject?) {
                                    
                                    let summaryDetailsModel = OrderSummaryModel(dict: summaryDetail as? NSDictionary)
                                    orderSummaryDetails.append(summaryDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return orderSummaryDetails
    }
    
    //MARK: - Prase Address Details
    
    func parseAddressDetails(object: AnyObject?) -> Array<CustomerLookUpAddressModel> {
        
        var addressDetails = Array<CustomerLookUpAddressModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    if let response = data as? NSArray {
                        //                        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "mainAddress", ascending: false)
                        //                        let sortedResults: NSArray = (response.sortedArray(using: [descriptor]) as NSArray)
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for addressDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(addressDetail as AnyObject?) {
                                    
                                    let addressDetailsModel = CustomerLookUpAddressModel(dict: addressDetail as? NSDictionary)
                                    addressDetails.append(addressDetailsModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return addressDetails
    }
    
    //MARK: - Parse AddressTypes
    
    func parseAddressTypes(object: AnyObject?) -> Array<AddressTypeModel> {
        
        var addressArray = Array<AddressTypeModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for addressDetails in response {
                                
                                if Utilities.sharedInstance.isObjectNull(addressDetails as AnyObject?) {
                                    
                                    let addressDetailsModel = AddressTypeModel(dict: addressDetails as? NSDictionary)
                                    addressArray.append(addressDetailsModel)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return addressArray
    }
    
    
    //MARK: - Prase States
    
    func parseStates(object: AnyObject?) -> Array<StatesModel> {
        
        var states = Array<StatesModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for state in response {
                                
                                if Utilities.sharedInstance.isObjectNull(state as AnyObject?) {
                                    
                                    let stateModel = StatesModel(dict: state as? NSDictionary)
                                    states.append(stateModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return states
    }
    
    
    //MARK: - Prase Countries
    
    func parseCountries(object: AnyObject?) -> Array<CountryModel> {
        
        var countries = Array<CountryModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for country in response {
                                
                                if Utilities.sharedInstance.isObjectNull(country as AnyObject?) {
                                    
                                    let countryModel = CountryModel(cuntry: country as? String)
                                    countries.append(countryModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return countries
    }
    
    //MARK: - Parse ShipVia Types
    
    func parseShipViaTypes(object: AnyObject?) -> Array<ShipViaTypeModel> {
        
        var shipViaTypesArray = Array<ShipViaTypeModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for shipViaType in response {
                                
                                if Utilities.sharedInstance.isObjectNull(shipViaType as AnyObject?) {
                                    
                                    let shipViaTypeModel = ShipViaTypeModel(dict: shipViaType as? NSDictionary)
                                    shipViaTypesArray.append(shipViaTypeModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return shipViaTypesArray
    }
    
    //MARK: - Prase Credit Card Details
    
    func parseCreditCardDetails(object: AnyObject?) -> Array<CreditCardModel> {
        
        var creditCardDetails = Array<CreditCardModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for orderDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
                                    
                                    let cardDetails = CreditCardModel(dict: orderDetail as? NSDictionary)
                                    creditCardDetails.append(cardDetails)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return creditCardDetails
    }
    
//    MARK: - Parse Contact Types
    
    func parseContactTypes(object: AnyObject?) -> Array<ContactTypeModel> {
        
        var contactsArray = Array<ContactTypeModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for contact in response {
                                
                                if Utilities.sharedInstance.isObjectNull(contact as AnyObject?) {
                                    
                                    let contactModel = ContactTypeModel(dict: contact as? NSDictionary)
                                    contactsArray.append(contactModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return contactsArray
    }
    
    //MARK: - Prase Customer Main Address Details
    
    func parseCustomerMainAddressDetails(object: AnyObject?) -> Array<CustomerAddressModel> {
        
        var addressDetails = Array<CustomerAddressModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for addressDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(addressDetail as AnyObject?) {
                                    
                                    let addressDetailsModel = CustomerAddressModel(dict: addressDetail as? NSDictionary)
                                    addressDetails.append(addressDetailsModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return addressDetails
    }
    
    func parseContactsDetails(object: AnyObject?) -> Array<CustomerContactsModel> {
        
        var contactDetails = Array<CustomerContactsModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for contactDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(contactDetail as AnyObject?) {
                                    
                                    let cardDetails = CustomerContactsModel(dict: contactDetail as? NSDictionary)
                                    contactDetails.append(cardDetails)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return contactDetails
    }
    
    //MARK: - Parse PaymentDue Info
    
    func parsePaymentDueInfo(object: AnyObject?) -> Array<MakePaymentModel> {
        
        var paymentDuesArray = Array<MakePaymentModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for paymentDue in response {
                                
                                if Utilities.sharedInstance.isObjectNull(paymentDue as AnyObject?) {
                                    
                                    let makePaymentDueModel = MakePaymentModel(dict: paymentDue as? NSDictionary)
                                    paymentDuesArray.append(makePaymentDueModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return paymentDuesArray
    }
    
    //MARK: - Prase Orders and Invoices
    
    func parseOrdersAndInvoices(object: AnyObject?) -> Array<OrderAndInvoiceModel> {
        
        var orderDetails = Array<OrderAndInvoiceModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for orderDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
                                    
                                    let orderDetailsModel = OrderAndInvoiceModel(dict: orderDetail as? NSDictionary)
                                    orderDetails.append(orderDetailsModel)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return orderDetails
    }
    
    //MARK: - Prase Orders and Invoice Details
    
    func parseOrdersAndInvoiceDetails(object: AnyObject?) -> Array<ListOrdersModel> {
        
        var listOrderDetails = Array<ListOrdersModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["data"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for listOrderDetail in response {
                                
                                if Utilities.sharedInstance.isObjectNull(listOrderDetail as AnyObject?) {
                                    
                                    let listDetailsModel = ListOrdersModel(dict: listOrderDetail as? NSDictionary)
                                    listOrderDetails.append(listDetailsModel)
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return listOrderDetails
    }
    
    //MARK: - Prase Item Details
    
    /*    func parseItemDetails(object: AnyObject?) -> Array<ItemDetailsModel> {
     
     var itemDetails = Array<ItemDetailsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for item in response {
     
     if Utilities.sharedInstance.isObjectNull(item as AnyObject?) {
     
     let countryModel = ItemDetailsModel(dict: item as? NSDictionary)
     itemDetails.append(countryModel)
     }
     }
     }
     }
     }
     
     return itemDetails
     }
     
     func parseRepDetails(object: AnyObject?) -> Array<RepModel> {
     
     var repDetails = Array<RepModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemGroup in response {
     
     if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
     
     let repModel = RepModel(dict: itemGroup as? NSDictionary)
     repDetails.append(repModel)
     }
     }
     }
     }
     
     }
     }
     }
     
     return repDetails
     }
     
     
     
     //MARK: - Prase Sub Categories
     
     func parseSubCategories(object: AnyObject?) -> Array<SubCategoriesModel> {
     
     var subCategories = Array<SubCategoriesModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for subCategory in response {
     
     if Utilities.sharedInstance.isObjectNull(subCategory as AnyObject?) {
     
     let categoryModel = SubCategoriesModel(dict: subCategory as? NSDictionary)
     subCategories.append(categoryModel)
     }
     }
     }
     }
     }
     
     return subCategories
     }
     
     //MARK: - Prase Item Groups
     
     func parseItemGroups(object: AnyObject?) -> Array<GroupsModel> {
     
     var itemGroups = Array<GroupsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemGroup in response {
     
     if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
     
     let groupsModel = GroupsModel(dict: itemGroup as? NSDictionary)
     itemGroups.append(groupsModel)
     }
     }
     }
     }
     }
     
     return itemGroups
     }
     
     //MARK: - Prase Item More
     
     func parseItemMore(object: AnyObject?) -> Array<ItemMoreModel> {
     
     var itemMore = Array<ItemMoreModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemGroup in response {
     
     if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
     
     let itemMoreModel = ItemMoreModel(dict: itemGroup as? NSDictionary)
     itemMore.append(itemMoreModel)
     }
     }
     }
     }
     
     }
     }
     }
     
     return itemMore
     }
     
     //MARK: - Parse Group
     func parseGroup(object: AnyObject?) -> Array<ItemDetailsModel> {
     
     var itemDetails = Array<ItemDetailsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemGroup in response {
     
     if Utilities.sharedInstance.isObjectNull(itemGroup as AnyObject?) {
     
     let itemDetailsModel = ItemDetailsModel(dict: itemGroup as? NSDictionary)
     itemDetails.append(itemDetailsModel)
     }
     }
     }
     }
     
     }
     }
     }
     
     return itemDetails
     }
     
     //MARK: - Prase Catalogs
     
     func parseCatalogs(object: AnyObject?) -> Array<CatalogsModel> {
     
     var catalogs = Array<CatalogsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for item in response {
     
     if Utilities.sharedInstance.isObjectNull(item as AnyObject?) {
     
     let catalogsModel = CatalogsModel(dict: item as? NSDictionary)
     catalogs.append(catalogsModel)
     }
     }
     }
     }
     }
     
     return catalogs
     }
     
     //MARK: - Prase Customer For Quotes
     
     func parseCustomerForQuotes(object: AnyObject?) -> Array<SearchCustomerForQuotesModel> {
     
     var customers = Array<SearchCustomerForQuotesModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for item in response {
     
     if Utilities.sharedInstance.isObjectNull(item as AnyObject?) {
     
     let customerModel = SearchCustomerForQuotesModel(dict: item as? NSDictionary)
     customers.append(customerModel)
     }
     }
     }
     }
     }
     }
     }
     
     return customers
     }
     
     //MARK: - Prase Existing Quotes
     
     func parseExistingQuotes(object: AnyObject?) -> Array<ExistingQuotesModel> {
     
     var existingQuotes = Array<ExistingQuotesModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for item in response {
     
     if Utilities.sharedInstance.isObjectNull(item as AnyObject?) {
     
     let existingQuotesModel = ExistingQuotesModel(dict: item as? NSDictionary)
     existingQuotes.append(existingQuotesModel)
     }
     }
     }
     }
     }
     }
     }
     
     return existingQuotes
     }
     
     //MARK: - Prase Buyers
     
     func parseBuyers(object: AnyObject?) -> Array<String> {
     
     var buyers = Array<String>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for buyer in response {
     
     if Utilities.sharedInstance.isObjectNull(buyer as AnyObject?) {
     
     if buyer is String {
     
     buyers.append(buyer as! String)
     }
     }
     }
     }
     }
     }
     }
     }
     
     return buyers
     }
     
     //MARK: - Prase States
     
     func parseStates(object: AnyObject?) -> Array<StatesModel> {
     
     var states = Array<StatesModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for state in response {
     
     if Utilities.sharedInstance.isObjectNull(state as AnyObject?) {
     
     let countryModel = StatesModel(dict: state as? NSDictionary)
     states.append(countryModel)
     }
     }
     }
     }
     }
     }
     }
     
     return states
     }
     
     
     //MARK: - Prase Freight Terms
     
     func parseFreightTypes(object: AnyObject?) -> Array<FreightTermsModel> {
     
     var frieghtTerms = Array<FreightTermsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for frieghtTerm in response {
     
     if Utilities.sharedInstance.isObjectNull(frieghtTerm as AnyObject?) {
     
     let freightTermModel = FreightTermsModel(dict: frieghtTerm as? NSDictionary)
     frieghtTerms.append(freightTermModel)
     }
     }
     }
     }
     }
     
     return frieghtTerms
     }
     
     //MARK: - Parse claimsubcodes
     
     func parseClaimSubCodeTypes(object: AnyObject?) -> Array<ClaimSubcodeModel> {
     
     var subcodes = Array<ClaimSubcodeModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for subcode in response {
     
     if Utilities.sharedInstance.isObjectNull(subcode as AnyObject?) {
     
     let freightTermModel = ClaimSubcodeModel(dict: subcode as? NSDictionary)
     subcodes.append(freightTermModel)
     }
     }
     }
     }
     }
     
     return subcodes
     }
     
     //MARK: - Prase Payment Terms
     
     func parsePaymentTypes(object: AnyObject?) -> Array<PaymentTermsModel> {
     
     var paymentTerms = Array<PaymentTermsModel>()
     
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for paymentTerm in response {
     
     if Utilities.sharedInstance.isObjectNull(paymentTerm as AnyObject?) {
     
     let paymentTermModel = PaymentTermsModel(dict: paymentTerm as? NSDictionary)
     paymentTerms.append(paymentTermModel)
     }
     }
     }
     }
     }
     
     return paymentTerms
     }
     
     //MARK: - Prase Countries
     
     func parseCountries(object: AnyObject?) -> Array<CountryModel> {
     
     var countries = Array<CountryModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for country in response {
     
     if Utilities.sharedInstance.isObjectNull(country as AnyObject?) {
     
     let countryModel = CountryModel(cuntry: country as? String)
     countries.append(countryModel)
     }
     }
     }
     }
     }
     }
     }
     
     return countries
     }
     
     //MARK: - Parse AddressTypes
     
     func parseAddressTypes(object: AnyObject?) -> Array<AddressTypeModel> {
     
     var addressArray = Array<AddressTypeModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for state in response {
     
     if Utilities.sharedInstance.isObjectNull(state as AnyObject?) {
     
     let addressModel = AddressTypeModel(dict: state as? NSDictionary)
     addressArray.append(addressModel)
     }
     }
     }
     }
     }
     
     return addressArray
     }
     
     //MARK: - Parse AddressTypes
     
     func parseClaimItem(object: AnyObject?) -> Array<ClaimInformationModel> {
     
     var itemArray = Array<ClaimInformationModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemDetails in response {
     
     if Utilities.sharedInstance.isObjectNull(itemDetails as AnyObject?) {
     
     let itemDetailModel = ClaimInformationModel(dict: itemDetails as? NSDictionary)
     itemArray.append(itemDetailModel)
     }
     }
     }
     }
     }
     }
     }
     
     return itemArray
     }
     
     //MARK: - Parse Profile Details
     
     func parseProfileDetails(object: AnyObject?) -> Array<ProfileModel> {
     
     var profilesArray = Array<ProfileModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for state in response {
     
     if Utilities.sharedInstance.isObjectNull(state as AnyObject?) {
     
     let profileModel = ProfileModel(dict: state as? NSDictionary)
     profilesArray.append(profileModel)
     }
     }
     }
     }
     }
     
     return profilesArray
     }
     

     
     
     //MARK: - Parse ShipVia Types
     
     func parseShipViaTypes(object: AnyObject?) -> Array<ShipViaTypeModel> {
     
     var shipViaTypesArray = Array<ShipViaTypeModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for state in response {
     
     if Utilities.sharedInstance.isObjectNull(state as AnyObject?) {
     
     let shipViaTypeModel = ShipViaTypeModel(dict: state as? NSDictionary)
     shipViaTypesArray.append(shipViaTypeModel)
     }
     }
     }
     }
     }
     
     return shipViaTypesArray
     }
     
     //MARK: - Prase Quotes For List
     
     func parseQuotesForList(object: AnyObject?) -> Array<QuotesForListModel> {
     
     var quotes = Array<QuotesForListModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for quote in response {
     
     if Utilities.sharedInstance.isObjectNull(quote as AnyObject?) {
     
     let countryModel = QuotesForListModel(dict: quote as? NSDictionary)
     quotes.append(countryModel)
     }
     }
     }
     }
     }
     }
     }
     
     return quotes
     }
     
     //MARK: - Prase Showrooms
     
     func parseShowRooms(object: AnyObject?) -> Array<ShowRoomsModel> {
     
     var showrooms = Array<ShowRoomsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for showroom in response {
     
     if Utilities.sharedInstance.isObjectNull(showroom as AnyObject?) {
     
     let showroomModel = ShowRoomsModel(dict: showroom as? NSDictionary)
     showrooms.append(showroomModel)
     }
     }
     }
     }
     }
     }
     }
     
     return showrooms
     }
     
     //MARK: - Parse Insert Update Quotes
     
     func parseInsertUpdateQuotes(object: AnyObject?) -> Int {
     
     var dataInt = 0
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? String {
     
     if Utilities.sharedInstance.isObjectNull(response as AnyObject?) {
     
     if let responseInt = Int(response) {
     
     dataInt = responseInt
     }
     }
     }
     }
     }
     }
     
     return dataInt
     }
     
     //MARK: - Prase Quote Item Details
     
     func parseQuoteItemDetails(object: AnyObject?) -> Array<QuoteItemDetailsModel> {
     
     var itemDetails = Array<QuoteItemDetailsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(itemDetail as AnyObject?) {
     
     let itemDetailsModel = QuoteItemDetailsModel(dict: itemDetail as? NSDictionary)
     itemDetails.append(itemDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return itemDetails
     }
     
     //MARK: - Prase Customer Add Item Details
     
     func parseCustomerItemDetails(object: AnyObject?) -> Array<CustomerAddItemModel> {
     
     var itemDetails = Array<CustomerAddItemModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(itemDetail as AnyObject?) {
     
     let customerItemDetailsModel = CustomerAddItemModel(dict: itemDetail as? NSDictionary)
     itemDetails.append(customerItemDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return itemDetails
     }
     
     //MARK: - Prase Address Details
     
     func parseAddressDetails(object: AnyObject?) -> Array<CustomerLookUpAddressModel> {
     
     var addressDetails = Array<CustomerLookUpAddressModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     
     if let response = data as? NSArray {
     //                        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "mainAddress", ascending: false)
     //                        let sortedResults: NSArray = (response.sortedArray(using: [descriptor]) as NSArray)
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for addressDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(addressDetail as AnyObject?) {
     
     let addressDetailsModel = CustomerLookUpAddressModel(dict: addressDetail as? NSDictionary)
     addressDetails.append(addressDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return addressDetails
     }
     
     func parseClaimAddressDetails(object: AnyObject?) -> Array<CustomerLookUpAddressModel> {
     
     var addressDetails = Array<CustomerLookUpAddressModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     
     if let response = data as? NSArray {
     let descriptor: NSSortDescriptor = NSSortDescriptor(key: "mainAddress", ascending: false)
     let sortedResults: NSArray = (response.sortedArray(using: [descriptor]) as NSArray)
     if Utilities.sharedInstance.isObjectNull(sortedResults) {
     
     for addressDetail in sortedResults {
     
     if Utilities.sharedInstance.isObjectNull(addressDetail as AnyObject?) {
     
     let addressDetailsModel = CustomerLookUpAddressModel(dict: addressDetail as? NSDictionary)
     addressDetails.append(addressDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return addressDetails
     }
     
     //MARK: - Prase Customer View Item Details
     
     func parseCustomerOrderItemsDetails(object: AnyObject?) -> Array<CustomerViewModel> {
     
     var itemDetails = Array<CustomerViewModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(itemDetail as AnyObject?) {
     
     let customerItemsViewModel = CustomerViewModel(dict: itemDetail as? NSDictionary)
     itemDetails.append(customerItemsViewModel)
     }
     }
     }
     }
     }
     }
     }
     
     return itemDetails
     }
     
     
     //MARK: - Prase Image response
     
     func parseImageResponse(object: AnyObject?) -> Array<ImageDownloadModel> {
     
     var imageDetails = Array<ImageDownloadModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(itemDetail as AnyObject?) {
     
     let imageModel = ImageDownloadModel(dict: itemDetail as? NSDictionary)
     imageDetails.append(imageModel)
     }
     }
     }
     }
     }
     }
     }
     
     return imageDetails
     }
     
     //MARK: - Prase List Claims Details
     
     func parseClaimsListDetails(object: AnyObject?) -> Array<ListClaimedItemsModel> {
     
     var claimDetails = Array<ListClaimedItemsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for claimDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(claimDetail as AnyObject?) {
     
     let claimsListModel = ListClaimedItemsModel(dict: claimDetail as? NSDictionary)
     claimDetails.append(claimsListModel)
     }
     }
     }
     }
     }
     }
     }
     
     return claimDetails
     }
     
     //ClaimedListModel
     
     //MARK: - Claimed List  Details
     
     func parseClaimedListDetails(object: AnyObject?) -> Array<ClaimedListModel> {
     
     var claimDetails = Array<ClaimedListModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for claimDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(claimDetail as AnyObject?) {
     
     let claimsListModel = ClaimedListModel(dict: claimDetail as? NSDictionary)
     claimDetails.append(claimsListModel)
     }
     }
     }
     }
     }
     }
     }
     
     return claimDetails
     }
     
     //MARK: - Prase Customer Main Address Details
     
     func parseCustomerMainAddressDetails(object: AnyObject?) -> Array<CustomerAddressModel> {
     
     var addressDetails = Array<CustomerAddressModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for addressDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(addressDetail as AnyObject?) {
     
     let addressDetailsModel = CustomerAddressModel(dict: addressDetail as? NSDictionary)
     addressDetails.append(addressDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return addressDetails
     }
     
     //MARK: - Prase Claim Return Address Details
     
     func parseClaimReturnAddressDetails(object: AnyObject?) -> Array<ClaimReturnAddressModel> {
     
     var addressDetails = Array<ClaimReturnAddressModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for addressDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(addressDetail as AnyObject?) {
     
     let addressDetailsModel = ClaimReturnAddressModel(dict: addressDetail as? NSDictionary)
     addressDetails.append(addressDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return addressDetails
     }
     
     //MARK: - Prase Customer View Order Details
     
     func parseCustomerViewOrderDetails(object: AnyObject?) -> Array<CustomerViewOrderDetailInfoModel> {
     
     var orderDetails = Array<CustomerViewOrderDetailInfoModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for itemDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(itemDetail as AnyObject?) {
     
     let customerViewOrderModel = CustomerViewOrderDetailInfoModel(dict: itemDetail as? NSDictionary)
     orderDetails.append(customerViewOrderModel)
     }
     }
     }
     }
     }
     }
     }
     
     return orderDetails
     }
     
     //MARK: - Prase Customer Order Item Details
     
     func parseTotalOrderDetails(object: AnyObject?) -> Array<TotalOrdersModel> {
     
     var orderDetails = Array<TotalOrdersModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for orderDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
     
     let totalOrderDetailsModel = TotalOrdersModel(dict: orderDetail as? NSDictionary)
     orderDetails.append(totalOrderDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return orderDetails
     }
     
     //MARK: - Prase Insert Update Item Quote
     
     func parseInsertUpdateQuoteItem(object: AnyObject?) -> String {
     
     var itemStatus = ""
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let statusMessage = response["statusMessage"]
     
     if Utilities.sharedInstance.isObjectNull(statusMessage as AnyObject?) {
     
     if let response = statusMessage as? NSString {
     
     itemStatus = response as String
     }
     }
     }
     }
     
     return itemStatus
     }
     
     //MARK: - Prase Quote For Values
     
     func parseQuoteForValues(object: AnyObject?) -> Array<QuoteForValuesModel> {
     
     var quoteValues = Array<QuoteForValuesModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for quoteValue in response {
     
     if Utilities.sharedInstance.isObjectNull(quoteValue as AnyObject?) {
     
     let quoteValuesModel = QuoteForValuesModel(dict: quoteValue as? NSDictionary)
     quoteValues.append(quoteValuesModel)
     }
     }
     }
     }
     }
     }
     }
     
     return quoteValues
     }
     
     //MARK: - Prase Quote Header
     
     func parseQuoteHeader(object: AnyObject?) -> Array<QuoteHeaderModel> {
     
     var quoteHeaderArray = Array<QuoteHeaderModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for quoteHeader in response {
     
     if Utilities.sharedInstance.isObjectNull(quoteHeader as AnyObject?) {
     
     let quoteHeaderModel = QuoteHeaderModel(dict: quoteHeader as? NSDictionary)
     quoteHeaderArray.append(quoteHeaderModel)
     }
     }
     }
     }
     }
     }
     }
     
     return quoteHeaderArray
     }
     
     //MARK: - Prase Quote Items
     
     func parseQuoteItems(object: AnyObject?) -> Array<QuoteItemModel> {
     
     var quoteItems = Array<QuoteItemModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for quoteItem in response {
     
     if Utilities.sharedInstance.isObjectNull(quoteItem as AnyObject?) {
     
     let quoteItemModel = QuoteItemModel(dict: quoteItem as? NSDictionary)
     quoteItems.append(quoteItemModel)
     }
     }
     }
     }
     }
     }
     }
     
     return quoteItems
     }
     
     //MARK: - Prase Current Specials
     
     func parseCurrentSpecials(object: AnyObject?) -> Array<SpecialsModel> {
     
     var specials = Array<SpecialsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for currentSpecial in response {
     
     if Utilities.sharedInstance.isObjectNull(currentSpecial as AnyObject?) {
     
     let specialsModel = SpecialsModel(dict: currentSpecial as? NSDictionary)
     specials.append(specialsModel)
     }
     }
     }
     }
     }
     
     return specials
     }
     
     //MARK: - Prase Account Details
     
     func parseAccountDetails(object: AnyObject?) -> Array<AccountsModel> {
     
     var accountsDetails = Array<AccountsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for accountsDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(accountsDetail as AnyObject?) {
     
     let accountsDetailsModel = AccountsModel(dict: accountsDetail as? NSDictionary)
     accountsDetails.append(accountsDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return accountsDetails
     }
     
     //MARK: - Prase Customer Billing Address
     
     func parseCustomerBillingAddress(object: AnyObject?) -> Array<BillingAddressModel> {
     
     var billingAddresses = Array<BillingAddressModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for billingAddress in response {
     
     if Utilities.sharedInstance.isObjectNull(billingAddress as AnyObject?) {
     
     let billingAddressModel = BillingAddressModel(dict: billingAddress as? NSDictionary)
     billingAddresses.append(billingAddressModel)
     }
     }
     }
     }
     }
     }
     }
     
     return billingAddresses
     }
     
     //MARK: - Prase Complete Order Details
     
     func parseCompleteOrderDetails(object: AnyObject?) -> Array<CompleteOrderModel> {
     
     var orderDetails = Array<CompleteOrderModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for orderDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
     
     let completeOrderModel = CompleteOrderModel(dict: orderDetail as? NSDictionary)
     orderDetails.append(completeOrderModel)
     }
     }
     }
     }
     }
     }
     }
     
     return orderDetails
     }
     
     //MARK: - Prase List Order Details
     
     func parseListOrderDetails(object: AnyObject?) -> Array<ListOrdersModel> {
     
     var listOrderDetails = Array<ListOrdersModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for orderDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
     
     let listOrderModel = ListOrdersModel(dict: orderDetail as? NSDictionary)
     listOrderDetails.append(listOrderModel)
     }
     }
     }
     }
     }
     }
     }
     
     return listOrderDetails
     }
     
     //MARK: - Prase Credit Card Details
     
     func parseCreditCardDetails(object: AnyObject?) -> Array<CreditCardModel> {
     
     var creditCardDetails = Array<CreditCardModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for orderDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(orderDetail as AnyObject?) {
     
     let cardDetails = CreditCardModel(dict: orderDetail as? NSDictionary)
     creditCardDetails.append(cardDetails)
     }
     }
     }
     }
     }
     }
     }
     
     return creditCardDetails
     } */
     

     
   /*  func parseLifeStyles(object: AnyObject?) -> Array<LifeStyleModel> {
     
     var lifeStyles = Array<LifeStyleModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for lifeStyleDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(lifeStyleDetail as AnyObject?) {
     
     let lifeStyleDetails = LifeStyleModel(dict: lifeStyleDetail as? NSDictionary)
     lifeStyles.append(lifeStyleDetails)
     }
     }
     }
     }
     }
     }
     }
     
     return lifeStyles
     }
     
     func parseShippingHistory(object: AnyObject?) -> Array<BookingAndShippingHistoryModel> {
     
     var historyDetails = Array<BookingAndShippingHistoryModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for bookingShippinghistory in response {
     
     if Utilities.sharedInstance.isObjectNull(bookingShippinghistory as AnyObject?) {
     
     let shippingHistory = BookingAndShippingHistoryModel(dict: bookingShippinghistory as? NSDictionary)
     historyDetails.append(shippingHistory)
     }
     }
     }
     }
     }
     }
     }
     
     return historyDetails
     }
     
     //MARK: - Prase Claims Info
     
     func parseClaimsDetails(object: AnyObject?) -> Array<ViewClaimsModel> {
     
     var claimsDetails = Array<ViewClaimsModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for claimDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(claimDetail as AnyObject?) {
     
     let claimModel = ViewClaimsModel(dict: claimDetail as? NSDictionary)
     claimsDetails.append(claimModel)
     }
     }
     }
     }
     }
     }
     }
     
     return claimsDetails
     }
     
     
     //MARK: Parse Order Summary
     
     func parseOrderSummary(object: AnyObject) -> Array<OrderSummaryModel> {
     
     var model = Array<OrderSummaryModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     if let dataArray = response.object(forKey: "data") as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(dataArray) {
     
     for summary in dataArray {
     
     if Utilities.sharedInstance.isObjectNull(summary as AnyObject?) {
     
     let categoryModel = OrderSummaryModel(dict: summary as? NSDictionary)
     model.append(categoryModel)
     }
     }
     
     }
     }
     }
     }
     }
     
     return model
     }
     
     //MARK: Parse LastVsCurrent Year Summary
     
     func parseLastVsCurrentYearSumary(object: AnyObject) -> LastVsCurrentYearSummaryModel {
     
     var item = LastVsCurrentYearSummaryModel()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     let model = LastVsCurrentYearSummaryModel(dict: response)
     item  = model
     }
     }
     }
     
     return item
     }
     
     //MARK: - Parse SalesRep Favorites
     
     func parseSalesRepFavorites(object: AnyObject?) -> Array<FavoriteModel> {
     
     var favoriteDetails = Array<FavoriteModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for favDetail in response {
     
     if Utilities.sharedInstance.isObjectNull(favDetail as AnyObject?) {
     
     let customerItemDetailsModel = FavoriteModel(dict: favDetail as? NSDictionary)
     favoriteDetails.append(customerItemDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return favoriteDetails
     }
     
     //MARK: - Parse Notifications Response
     
     func parseNotificationsList(object: AnyObject?) -> Array<NotificationsListModel> {
     
     var notificationsList = Array<NotificationsListModel>()
     
     if Utilities.sharedInstance.isObjectNull(object) {
     
     if let response = object as? NSDictionary {
     
     let data = response["data"]
     
     if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
     if let response = data as? NSArray {
     
     if Utilities.sharedInstance.isObjectNull(response) {
     
     for notificationDetails in response {
     
     if Utilities.sharedInstance.isObjectNull(notificationDetails as AnyObject?) {
     
     let notificationDetailsModel = NotificationsListModel(dict: notificationDetails as? NSDictionary)
     notificationsList.append(notificationDetailsModel)
     }
     }
     }
     }
     }
     }
     }
     
     return notificationsList
     }
 
 
}  */
 
 }*/

}
