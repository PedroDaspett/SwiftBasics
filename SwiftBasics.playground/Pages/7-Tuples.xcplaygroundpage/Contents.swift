import Foundation


var userName: String = "Hello"
var userIsPremium: Bool = false
var userIsNew: Bool = true

@MainActor
func getUserName() -> String {
    userName
}
@MainActor
func getUserIsPremium() -> Bool {
    userIsPremium
}

// limited to 1 return type
@MainActor
func getUserInfo() -> String {
    
    let name = getUserName()
    let isPremium = getUserIsPremium()
    
    return name
}

// tuple can combine multiple pieces of data
@MainActor
func getUserInfo2() -> (String, Bool) {
    let name = getUserName()
    let isPremium = getUserIsPremium()
    
    return (name, isPremium)
}

var userData1: String = userName
var userData2: (String, Bool, Bool) = (userName, userIsPremium, userIsNew)


let info1 = getUserInfo2()
let name1: String = info1.0

@MainActor
func getUserInfo3() -> (name: String, isPremium: Bool) {
    let name = getUserName()
    let isPremium = getUserIsPremium()
    
    return (name, isPremium)
}

let info2 = getUserInfo3()
let name2 = info2.name

@MainActor
func getUserInfo4() -> (name: String, isPremium: Bool, isNew: Bool) {
    return (userName, userIsPremium, userIsNew)
}

func doSomethingWithUserInfo(info: (name: String, isPremium: Bool, isNew: Bool)) {
    
}


let info = getUserInfo4()
doSomethingWithUserInfo(info: info)
