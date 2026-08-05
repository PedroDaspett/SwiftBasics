//Escrever um método para computar o input e retornar o output
//input: "AAAA222CCDAA"
//output: "A423C2D1A2"
//Testes:
//• Validar caso a entrada seja vazia: ex '''
//• Validar caso tenha mais de 9 letras repetidas: "AAAAAAAAAAB" → "A9A1B1"
//• Validar letras e números

let input = ["AAAA222CCDAA", "aabc", "aaa", "", "AAAAAAAAAAB", "ABCDEAFGIJKIM"]

func countChars(str: String) -> String {
    guard
        var currentChar = str.first,
        str.allSatisfy( { $0.isLetter || $0.isNumber } ) else {
        return "Entre com um valor válido."
    }
    
    var newStr: String = ""
    var currentCount: Int = 0
    
    for character in str {
        if currentChar == character && currentCount < 9 {
            currentCount += 1
        } else {
            newStr += "\(currentChar)\(currentCount)"
            currentChar = character
            currentCount = 1
        }
    }
    
    newStr += "\(currentChar)\(currentCount)"
    
    return newStr
}

let output = input.map {
    countChars(str: $0)
}

print(output)


//Escrever um método para computar o input e retornar o output
//input: "A423C2D1A2"
//output: "AAAA222CCDAA"
//Testes:
//• Validar caso a entrada seja vazia: ex "''
//• Validar letras e números

let input2 = "A423C2D1A2"

func decompress(string: String) -> String {
    guard
        var currentChar = string.first,
        string.allSatisfy({
            $0.isLetter || $0.isNumber
        })
    else {
        return "Entre com um valor válido."
    }
    
    var result: String = ""
    var currentCount: Int
    var stringCount: String
    var switcher: Bool = true
    
    for character in string {
        if switcher {
            currentChar = character
            result += "\(character)"
        } else {
            stringCount = "\(character)"
            currentCount = Int(stringCount) ?? 1
            result += String.init(repeating: "\(currentChar)", count: currentCount - 1)
        }
        switcher = !switcher
    }
    
    return result
}

let output2 = decompress(string: input2)

print(output2)

//Escrever um método que receba duas versões em SemVer e retorne a maior ou menor
//input: 2.3.0, 2.3.1
//output: 2.3.1
//Testes:
//• Validar caso a versão não esteja completa, por exemplo: 2.2
//• Validar se as versões são iguais.
//• Validar inputs do tipo A.2.0 (letras as invés de números)

let input3 = ("3.4.0", "2.3.9")

let output3 = latestVersion(first: input3.0, second: input3.1)

print(output3)

func parseVersion(_ version: String) -> [Int]? {
    let components = version.split(separator: ".")
    
    guard components.count == 3 else {
        return nil
    }
    
    let numbers = components.compactMap { Int($0) }
    
    guard numbers.count == 3 else {
        return nil
    }
    
    return numbers
}

func latestVersion(first: String, second: String) -> String {
    guard
        let firstVersion = parseVersion(first),
        let secondVersion = parseVersion(second)
    else {
        return "Versão inválida."
    }
    
    for index in 0...2 {
        if firstVersion[index] > secondVersion[index] {
            return first
        }
        
        if firstVersion[index] < secondVersion[index] {
            return second
        }
    }
    return "Versões são iguais."
}

//Escrever um conversor de String para Inteiro
//Dado um input inteiro
//input: "12304"
//output: 12304


