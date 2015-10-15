//
//  main.swift
//  domain-modeling
//
//  Created by Vivian on 10/14/15.
//  Copyright © 2015 Vivian. All rights reserved.
//

import Foundation


/* MONEY */

struct Money {
    // properties
    var amount: Double
    var currency: String
    
    init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
        
        if (currency != "USD" && currency != "GBP" && currency != "EUR" && currency != "CAN") {
            print("Only the following currencies are accepted: USD, GBP, EUR or CAN")
        }
    }

    func convert(newCurrency: String) -> Money {
        var convertedMoney = Money(amount: self.amount, currency: newCurrency)
        switch newCurrency {
            case "USD":
                switch currency {
                    case "USD":
                        convertedMoney.amount = amount
                    case "GBP":
                        convertedMoney.amount = amount * 2
                    case "EUR":
                        convertedMoney.amount = amount * (2/3)
                    case "CAN":
                        convertedMoney.amount = amount * (4/5)
                    default:
                        print("Only the following currencies are accepted: USD, GBP, EUR or CAN")
                }
            case "GBP":
                switch currency {
                    case "USD":
                        convertedMoney.amount = amount * (1/2)
                    case "GBP":
                        convertedMoney.amount = amount
                    case "EUR":
                        convertedMoney.amount = amount * (1/3)
                    case "CAN":
                        convertedMoney.amount = amount * (2/5)
                    default:
                        print("Only the following currencies are accepted: USD, GBP, EUR or CAN")
                }
            case "EUR":
                switch currency {
                    case "USD":
                        convertedMoney.amount = amount * (3/2)
                    case "GBP":
                        convertedMoney.amount = amount * 3
                    case "EUR":
                        convertedMoney.amount = amount
                    case "CAN":
                        convertedMoney.amount = amount * (6/5)
                    default:
                        print("Only the following currencies are accepted: USD, GBP, EUR or CAN")
                }
            case "CAN":
                switch currency {
                    case "USD":
                        convertedMoney.amount = amount * (5/4)
                    case "GBP":
                        convertedMoney.amount = amount * (5/2)
                    case "EUR":
                        convertedMoney.amount = amount * (5/6)
                    case "CAN":
                        convertedMoney.amount = amount
                    default:
                        print("Only the following currencies are accepted: USD, GBP, EUR or CAN")
                }
            default:
                print("Only the following currencies are accepted: USD, GBP, EUR or CAN")
        }
        return convertedMoney
    }
    
    func add(money2: Money) -> Money {
        var addedMoney = Money(amount: 0, currency: self.currency)
        let convertedMoney2 = money2.convert(self.currency)
        addedMoney.amount = self.amount + convertedMoney2.amount
        return addedMoney
    }
    
    func subtract(money2: Money) -> Money {
        var subtractedMoney = Money(amount: 0, currency: self.currency)
        let convertedMoney2 = money2.convert(self.currency)
        subtractedMoney.amount = self.amount - convertedMoney2.amount
        return subtractedMoney
    }
}

/*
1 USD = .5 GBP (2 USD = 1 GBP) 1/2 (4 USD = 2 GBP)
1 USD = 1.5 EUR (2 USD = 3 EUR) 3/2 (4 USD = 6 EUR)
1 USD = 1.25 CAN (4 USD = 5 CAN) 5/4
*/

// money objects
var mon1 = Money(amount: 5.00, currency: "CAN")
var mon2 = Money(amount: 1.00, currency: "USD")

// testing
print(mon1.convert("USD"))
print(mon2.convert("CAN"))

print(mon1.add(mon2))
print(mon1.subtract(mon2))








/* JOB */

class Job {
    // properties
    var title: String
    var salary: Double

    // salary = per hour
    // 2000 hours / year
    init(title: String, salary: Double) {
        self.title = title
        self.salary = salary
    }
    
    func calculateIncome(hoursWorked: Int) -> Double {
        return salary * Double(hoursWorked)
    }
    
    func raise(percentage: Double) {
        return salary *= (1 + percentage)
    }
}





/* PERSON */

class Person {
    // properties
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job?
    var spouse: Person?
    
    
    // under 16, cannot have job
    // under 18, cannot have spouse
    
    init(firstName: String, lastName: String, age: Int, job: Job?, spouse: Person) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
        if age < 16 {
            print("Person under the age 16 cannot have a job.")
        } else {
            self.job = job
        }
        
        if age < 18 {
            print("Person under the age 16 cannot have a spouse.")
        } else {
            self.spouse = spouse
        }
    }
    
    func toString() -> String {
        var personString: String
        if self.job != nil && self.spouse != nil {
            personString = ("Name: \(firstName) \(lastName) Age: \(age) Job: \(job!.title) Spouse: \(spouse!.firstName)")
        } else if self.job != nil {
            personString = ("Name: \(firstName) \(lastName) Age: \(age) Job: \(job!.title)")
        } else if self.spouse != nil {
            personString = ("Name: \(firstName) \(lastName) Age: \(age) Spouse: \(spouse!.firstName)")
        } else {
            personString = ("Name: \(firstName) \(lastName) Age: \(age)")
        }
        return personString
    }
}



/* FAMILY */

class Family {
    // properties
    var members: [Person]
    
    init(members: [Person]) {
        self.members = members
    }
    
    func householdIncome() -> Double {
        var totalIncome: Double = 0.0
        for member in members {
            if member.job != nil {
                totalIncome += member.job!.calculateIncome(2000)
            }
        }
        return totalIncome
    }
    
    func haveChild() {
        
    }
}