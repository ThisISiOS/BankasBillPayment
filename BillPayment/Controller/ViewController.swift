//
//  ViewController.swift
//  BillPayment
//
//  Created by Hetal Patel on 03/12/20.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    var pickerData: [String] = [String]()
    var selectedOption = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setPicker()
        self.setTextfield()
        
    }
    //MARK:- Button
    @IBAction func proceedClick(_ sender: Any) {
        if (selectedOption.trim.count != 0)
        {
        let options = self.selectedOption.split(separator: " ")
        let detailController = Controller.Detail
        detailController.selectedOption = String(options.last ?? "")
        self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
    
    //MARK: UI
    func setTextfield()
    {
        self.typeText.delegate = self
    }
    func setPicker()
    {
        typeText.inputView = self.typePicker
        self.typePicker.delegate = self
        self.typePicker.dataSource = self
        pickerData = ["Option 1", "Option 2", "Option 3"]
    }
}
extension ViewController : UITextFieldDelegate
{
    //MARK: Textfield Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (self.selectedOption.trim.count == 0)
        {
            self.selectedOption = "Option 1"
        }
        self.typeText.text = self.selectedOption
    }
}
extension ViewController : UIPickerViewDelegate,UIPickerViewDataSource
{
    //MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pickerData[row]
        self.typeText.text = pickerData[row]
    }
}


