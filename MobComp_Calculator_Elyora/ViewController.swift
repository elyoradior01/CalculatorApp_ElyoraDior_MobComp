//
//  ViewController.swift
//  MobComp_Calculator_Elyora
//
//  Created by MacBook Pro on 30/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    var currentInput: String = ""
//    var previousInput: String = ""
//    var currentOperator: String = ""
    
    var isResultDisplayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func digitz(_ sender: UIButton) {
        if let angka = sender.titleLabel?.text {
               if isResultDisplayed {
                   currentInput = angka
                   isResultDisplayed = false
               } else if currentInput.isEmpty {
                   currentInput = angka
               } else if !(angka == "," || angka == ".") {
                   if currentInput == "0" {
                       currentInput = angka
                   } else if currentInput.contains(".") || currentInput.contains(",") {
                       // Check if the current input already contains a decimal point
                       currentInput += angka
                   } else {
                       currentInput += angka
                   }
               }
               updateResultLabel()
           }
    }
    
    
    @IBAction func operationz(_ sender: UIButton) {
        if let operationSign = sender.titleLabel?.text {
            currentInput += operationSign
        }
    }
    
   
    @IBAction func commaButton(_ sender: UIButton) {
        if currentInput.isEmpty || currentInput.contains(".") || currentInput.contains(",") {
                return
            }
           
            currentInput += "."
            
            updateResultLabel()
    }
    
    
    @IBAction func backspaceButton(_ sender: UIButton) {
        if !currentInput.isEmpty {
            currentInput.removeLast()
            updateResultLabel()
        }
    }
    
    var hasilAkhir: Double = 0.0
//    var operatorAkhir: String = ""
    
    @IBAction func equalz(_ sender: UIButton) {
        
        if currentInput.isEmpty {
            return
        }
        
        let expression = NSExpression(format: currentInput)
            
            if let hasil = expression.expressionValue(with: nil, context: nil) as? Double {
                let angkaTidakKoma = floor(hasil) == hasil
                
                let formatter = NumberFormatter()
                formatter.maximumFractionDigits = angkaTidakKoma ? 0 : 8
                currentInput = formatter.string(from: NSNumber(value: hasil)) ?? ""
                
                hasilAkhir = hasil
                
                updateResultLabel()
                
                isResultDisplayed = true
            } else {
                resultLabel.text = "Error"
            }
        
    }
    
//    @IBAction func equalzLagi(_ sender: UIButton) {
//        if !operatorAkhir.isEmpty{if let angka2 = Double(currentInput){
//            switch operatorAkhir {
//            case "+":
//                hasilAkhir += angka2
//            case "-":
//                hasilAkhir -= angka2
//            case "*":
//                hasilAkhir *= angka2
//            case "/":
//                if angka2 != 0 {
//                hasilAkhir /= angka2
//                } else {
//                resultLabel.text = "Error"
//                return
//                }
//            default:
//                return
//        }
//            currentInput = String(hasilAkhir)
//            updateResultLabel()
//        }
//            
//        }
//        
//        
//    }
    
    @IBAction func clearAllButton(_ sender: UIButton) {
        currentInput = ""
//        previousInput = ""
//        currentOperator = ""
        updateResultLabel()
    }
    
    
    @IBAction func plusMinus(_ sender: UIButton) {
        if !currentInput.isEmpty{
            if currentInput.first == "-"{
                currentInput.removeFirst()
            }else {
                currentInput = "-" + currentInput
            }
            updateResultLabel()
        }
    }
    
    
    @IBAction func percentButton(_ sender: UIButton) {
        if let diskon = Double(currentInput){
            let percentage = diskon / 100.0
            currentInput = String(percentage)
            updateResultLabel()
        }
    }
    
    func updateResultLabel() {
        resultLabel.text = currentInput
    }



}

