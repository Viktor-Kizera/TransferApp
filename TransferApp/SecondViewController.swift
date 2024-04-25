//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Viktor Kizera on 23.04.2024.
//

import Foundation
import UIKit
protocol UpdatingDataController: AnyObject {
    var updatingData: String {get set}
}
class SecondViewController: UIViewController, UpdatingDataController {
    var completionHandler: ((String) -> Void)?
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    @IBOutlet weak var dataTextField: UITextField!
    var updatingData: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withtext: updatingData)
    }
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        completionHandler?(updatedData)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewScreen = storyboard.instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController( viewScreen , animated: true)
        navigationController?.viewControllers.forEach {viewController in
            if var check = (viewController as? UpdatableDataController){
                check.updatedData = dataTextField.text ?? " "}}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else {
            return  }
       destinationController.updatedData = dataTextField.text ?? ""
    }
    private func updateTextFieldData(withtext text: String) {
        dataTextField.text = text
    }
}

