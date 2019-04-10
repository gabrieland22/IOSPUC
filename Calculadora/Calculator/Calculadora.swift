import Foundation

struct Calculadora {
    enum Operacao {
        case soma
        case multiplica
        case divide
        case subtrai
    }


    func perform(operation: Calculadora.Operacao,
                 firstValue: Int,
                 secondValue: Int) -> Int {
        
        switch operation {
            case Calculadora.Operacao.soma:
                 return firstValue + secondValue
            case Calculadora.Operacao.subtrai:
                return firstValue - secondValue
            case Calculadora.Operacao.multiplica:
                return firstValue * secondValue
            case Calculadora.Operacao.divide:
                return firstValue / secondValue
        }
    }
}
