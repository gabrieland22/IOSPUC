//
//  ViewController.swift
//  CalculaIdade
//
//  Created by user151694 on 3/26/19.
//  Copyright © 2019 PUC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum AgeError: Error {
        case emptyText
        case invalidFormat
        case invalidDate
        case futureBirthDay
        case unknow
    }
    
    @IBOutlet weak var lblResultado: UILabel!
    @IBOutlet weak var txtDataNascimento: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

 
    @IBAction func actionButtonCalcular(_ sender: UIButton) {
        do{
            lblResultado.text  = "\(try calcularIdade(from: txtDataNascimento.text, Formato: "dd/MM/yyyy")) anos"
        } catch AgeError.emptyText {
            lblResultado.text = "Data não informada!"
        } catch AgeError.futureBirthDay {
            lblResultado.text = "Prevendo o futuro!?"
        } catch AgeError.invalidDate {
            lblResultado.text = "Data inválida!"
        } catch AgeError.invalidFormat {
            lblResultado.text = "Formato inválido!"
        } catch AgeError.unknow {
            lblResultado.text = "Erro desconhecido!"
        } catch {
            lblResultado.text = "Erro inesperado: \(error)."
        }
    }
    
    private func calcularIdade (from Data: String?, Formato: String) throws -> Int {
        
        if !(Data? .isEmpty)! {
                let dataRepassada = Data
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "pt_BR")
                dateFormatter.dateFormat = Formato
            if let dataAniversario = dateFormatter.date(from: dataRepassada!) {
                    
                    let now = Date()
                    guard dataAniversario <= now else { throw AgeError.futureBirthDay }
                    
                    if let age = Calendar.current.dateComponents([.year], from: dataAniversario, to: now ).year {
                        return age
                    } else {
                        throw AgeError.invalidDate
                    }
                    
                } else{
                    throw AgeError.invalidFormat
                }
                
            } else { throw AgeError.emptyText }

    }
}

