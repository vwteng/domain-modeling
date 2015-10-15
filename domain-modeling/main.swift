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
    
    // adds the 2nd to the 1st Money and returns a Money object in terms of the 1st currency
    func add(money2: Money) -> Money {
        var addedMoney = Money(amount: 0, currency: self.currency)
        let convertedMoney2 = money2.convert(self.currency)
        addedMoney.amount = self.amount + convertedMoney2.amount
        return addedMoney
    }
    
    // subtracts the 2nd from the 1st Money and returns a Money object in terms of the 1st currency
    func subtract(money2: Money) -> Money {
        var subtractedMoney = Money(amount: 0, currency: self.currency)
        let convertedMoney2 = money2.convert(self.currency)
        subtractedMoney.amount = self.amount - convertedMoney2.amount
        return subtractedMoney
    }
}

// TESTING FOR MONEY

print("TEST FOR MONEY")
var mon1 = Money(amount: 5.00, currency: "CAN")
var mon2 = Money(amount: 1.00, currency: "USD")
var mon3 = Money(amount: 1.50, currency: "EUR")
var mon4 = Money(amount: 1.50, currency: "CAN")
var bad1 = Money(amount: 12.34, currency: "ABC")

print("Convert Money")
print(mon1.convert("USD")) // 5 CAN -> 4 USD
print(mon2.convert("CAN")) // 1 USD -> 1.25 CAN
print(mon3.convert("USD")) // 1.50 EUR -> 1 USD
print(mon1.convert("GBP")) // 5 CAN -> 2 GBP
print("")

print("Add/Subtract Money")
print(mon1.add(mon2)) // 5 CAN + 1 USD = 6.25 CAN
print(mon1.add(mon4)) // 5 CAN + 1.50 CAN = 6.50 CAN
print(mon1.subtract(mon2)) // 5 CAN - 1 USD = 3.75 CAN
print(mon1.subtract(mon4)) // 5 CAN - 1.50 CAN = 3.50 CAN
print("")
print("")





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
    
    // returns the income based on hours worked
    func calculateIncome(hoursWorked: Int) -> Double {
        return salary * Double(hoursWorked)
    }
    
    // takes in percentage raised as a decimal and updates the salary in Job
    func raise(percentage: Double) {
        self.salary *= (1 + percentage)
    }
}

// TESTING FOR JOB

print("TEST FOR JOB")
var job1 = Job(title: "Doctor", salary: 95.00)
var job2 = Job(title: "Engineer", salary: 52.50)
var job3 = Job(title: "Teacher", salary: 35.49)

print(job1.calculateIncome(100))
print(job2.calculateIncome(150))
print(job3.calculateIncome(253))
job1.raise(0.50)
job2.raise(0.25)
print(job1.salary) // 95 -> raised 50% = 142.50
print(job2.salary) // 52.50 -> raise 25% = 65.625
print(job1.calculateIncome(2000))
print(job2.calculateIncome(2000))
print(job3.calculateIncome(2000))
print("")





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
    init(firstName: String, lastName: String, age: Int, job: Job?, spouse: Person?) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
        if age < 16  && job != nil{
            print("Person must be 16 or older to have a job.")
        } else {
            self.job = job
        }
        
        if age < 18 && spouse != nil {
            print("Person must be 18 or older to have a spouse.")
        } else {
            self.spouse = spouse
        }
    }
    
    func toString() {
        if self.job != nil && self.spouse != nil {
            print("My name is \(firstName) \(lastName) and I am \(age) years old. My job is \(job!.title) and my spouse is \(spouse!.firstName).")
        } else if self.job != nil {
            print("My name is \(firstName) \(lastName) and I am \(age) years old. My job is \(job!.title).")
        } else if self.spouse != nil {
            print("My name is \(firstName) \(lastName) and I am \(age) years old. My spouse is \(spouse!.firstName).")
        } else {
            print("My name is \(firstName) \(lastName) and I am \(age) years old.")
        }
    }
}

// TESTING FOR PERSON

print("TEST FOR PERSON")
var p1 = Person(firstName: "John", lastName: "Smith", age: 25, job: job1, spouse: nil)
var p2 = Person(firstName: "Bob", lastName: "Armstrong", age: 12, job: nil, spouse: nil)
var p3 = Person(firstName: "Anna", lastName: "McDonald", age: 38, job: job2, spouse: nil)
var p4 = Person(firstName: "Henry", lastName: "David", age: 42, job: job3, spouse: p3)
var illegal1 = Person(firstName: "Anna", lastName: "McDonald", age: 13, job: job2, spouse: nil)
var illegal2 = Person(firstName: "Henry", lastName: "David", age: 10, job: nil, spouse: p3)

p1.toString()
p2.toString()
p3.toString()
p4.toString()
print("")




/* FAMILY */

class Family {
    // properties
    var members: [Person]
    
    init(members: [Person]) {
        self.members = members
    }
    
    // returns total income for one year/2000 hours
    func householdIncome() -> Double {
        var totalIncome: Double = 0.0
        for member in members {
            if member.job != nil {
                totalIncome += member.job!.calculateIncome(2000)
            }
        }
        return totalIncome
    }
    
    // takes in a name to create a new Person to add to the members of Family
    func haveChild(firstName: String, lastName: String) {
        var legalFamily = false
        for member in members {
            if member.age >= 21 {
                legalFamily = true
            }
        }
        
        if legalFamily {
            members.append(Person(firstName: firstName, lastName: lastName, age: 0, job: nil, spouse: nil))
        } else {
            print("There must be at least one person in the family who is over 21 to have a child.")
        }
    }
}

// TESTING FOR FAMILY

print("TEST FOR FAMILY")
var fam = Family(members: [p1, p2, p3, p4])
print(fam.householdIncome())
fam.haveChild("Samantha", lastName: "Jones")

var fam2 = Family(members: [illegal1, illegal2])
print(fam2.householdIncome())
fam2.haveChild("Daniel", lastName: "Tate")