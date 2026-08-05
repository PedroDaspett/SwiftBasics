import Foundation

func myFirstFunction() {
    print("MY FIRST FUNCTION CALLED")
    mySecondFunction()
    myThirdFunction()
}

func mySecondFunction() {
    print("MY SECOND FUNCTION CALLED")
}

func myThirdFunction() {
    print("MY THIRD FUNCTION CALLED")
}

myFirstFunction()

func getUserName() -> String {
    let username: String = "Nick"
    return username
}

func checklfUserIsPremium() -> Bool {
    return false
}

let name: String = getUserName()

// --------------------------------------------------

showFirstScreen()

func showFirstScreen() {
    var userDidCompleteOnboarding: Bool = false
    var userProfileIsCreated: Bool = true
    
    let status = checkUserStatus(didCompleteOnboarding: userDidCompleteOnboarding, profileIsCreated: userProfileIsCreated)
    
    if status == true {
        print ("SHOW HOME SCREEN")
    }
    else {
        print ("SHOW ONBOARDING SCREEN")
    }
}

func checkUserStatus(didCompleteOnboarding: Bool, profileIsCreated: Bool) -> Bool {
    if didCompleteOnboarding && profileIsCreated {
        return true
    } else {
        return false
    }
}

// --------------------------------------------------

let newValue = doSomething()

func doSomething() -> String {
    var title: String = "Avengers"
    
    // "If title is equal to Avengers"
    if title == "Avengers" {
        return "Marvel"
    } else {
        return "Not Marvel"
    }
}

checkIfTitleIsAvengers()

func checkIfTitleIsAvengers() -> Bool {
    var title: String = "Avengers"
    
    // "Make sure title == Avengers
    guard title == "Avengers" else {
        return false
    }
    return true
}

func checkIfTitleIsAvengers2() -> Bool {
    var title: String = "Avengers"
    
    if title == "Avengers" {
        return true
    } else {
        return false
    }
}


// Calculated variables are basically functions
// Generally good for when you don't need to pass data into the function

let number1 = 5
let number2 = 8

// This is the same as...
func calculateNumbers() -> Int {
    return number1 + number2
}

// This:
var calculatedNumber: Int {
    return number1 + number2
}
