import UIKit

class ViewController: UIViewController {
    // Outlets

    @IBOutlet private weak var digit0Button: UIButton!
    @IBOutlet private weak var digit1Button: UIButton!
    @IBOutlet private weak var digit2Button: UIButton!
    @IBOutlet private weak var digit3Button: UIButton!
    @IBOutlet private weak var digit4Button: UIButton!
    @IBOutlet private weak var digit5Button: UIButton!
    @IBOutlet private weak var digit6Button: UIButton!
    @IBOutlet private weak var digit7Button: UIButton!
    @IBOutlet private weak var digit8Button: UIButton!
    @IBOutlet private weak var digit9Button: UIButton!
    @IBOutlet private weak var cleanButton: UIButton!
    @IBOutlet private weak var sumOpButton: UIButton!
    @IBOutlet private weak var subtractOpButton: UIButton!
    @IBOutlet private weak var timesOpButton: UIButton!
    @IBOutlet private weak var divideOpButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    // MARK: - Stored Properties

    private let calculator = Calculadora()
    private var firstValue: Int = 0
    private var secondValue: Int = 0
    private var operation: Calculadora.Operacao = Calculadora.Operacao.soma
    private var calculating: Bool = true
    
    

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        resultLabel.text = "0"
        
        registerTouchEvents()
    }



   
    private func registerTouchEvents() {
        let teclasNumericas = [digit0Button, digit9Button, digit8Button,
                            digit7Button, digit6Button, digit5Button,
                            digit4Button, digit3Button, digit2Button,
                            digit1Button]

        let teclasOperacoes = [sumOpButton, subtractOpButton, timesOpButton, divideOpButton]

        teclasNumericas.forEach { $0?.addTarget(self, action: #selector(digitarNumero(sender:)), for: .touchUpInside) }
        teclasOperacoes.forEach { $0?.addTarget(self, action: #selector(digitarOperacao(sender:)), for: .touchUpInside) }
        cleanButton.addTarget(self, action: #selector(Limpar), for: .touchUpInside)
        equalButton.addTarget(self, action: #selector(realizaOperacao), for: .touchUpInside)
    }

    //Adiciona um digito na calculadora
    @objc func digitarNumero(sender: UIButton) {
        
        var digito: String
        
        switch sender {
            case digit0Button:
                digito = "0"
            case digit1Button:
                digito = "1"
            case digit2Button:
                digito = "2"
            case digit3Button:
                digito =  "3"
            case digit4Button:
                digito =  "4"
            case digit5Button:
                digito =  "5"
            case digit6Button:
                digito =  "6"
            case digit7Button:
                digito =  "7"
            case digit8Button:
                digito =  "8"
            case digit9Button:
                digito =  "9"
            default:
                return
        }
        
        if calculating {
            resultLabel.text = digito
            calculating = false
        } else {
            resultLabel.text! += digito
        }
        secondValue = Int(resultLabel.text!)!
    }

    //Limpa a tela botão AC
    @objc func Limpar() {
        resultLabel.text = "0"
        firstValue = 0
        secondValue = 0
        calculating = true
    }

    //Identifica a operação
    @objc func digitarOperacao(sender: UIButton) {
        if resultLabel.text != "+" && resultLabel.text != "-" && resultLabel.text != "*" && resultLabel.text != "/" {
            firstValue = Int(resultLabel.text!)!
        }
            
        switch sender {
            case sumOpButton:
                resultLabel.text = "+"
                operation = Calculadora.Operacao.soma
            case subtractOpButton:
                resultLabel.text = "-"
                operation = Calculadora.Operacao.subtrai
            case timesOpButton:
                resultLabel.text = "*"
                operation = Calculadora.Operacao.multiplica
            case divideOpButton:
                resultLabel.text = "/"
                operation = Calculadora.Operacao.divide
            default:
                return
            }
        
        calculating = true
    }

    /// Método acionado quando o botão = é tocado.
    @objc func realizaOperacao() {
        resultLabel.text  = String(calculator.perform(operation: operation, firstValue: firstValue, secondValue: secondValue))
        firstValue = 0
        secondValue = 0
        calculating = false
    }
}
