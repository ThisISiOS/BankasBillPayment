//
//  BPPaymentDetailController.swift
//  BillPayment
//
//  Created by Hetal Patel on 04/12/20.
//

import UIKit
import ObjectMapper
import Alamofire
class BPPaymentDetailController: UIViewController {
    
    @IBOutlet weak var fieldsTable: UITableView!
    var selectedOption = ""
    var field : [BPFields] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getOptions()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func proceedClick(_ sender: Any) {
        self.validateInput()
        
    }
    //MARK: Set UI
    
    func setTable()
    {
        self.fieldsTable.register(CellNib.FieldsCell, forCellReuseIdentifier: CellIdentifier.FieldsCell)
        self.fieldsTable.delegate = self
        self.fieldsTable.dataSource = self
        self.fieldsTable.estimatedRowHeight = 44.0
        self.fieldsTable.rowHeight = UITableView.automaticDimension
        self.fieldsTable.reloadData()
    }
    
}
extension BPPaymentDetailController
{
    //MARK: API
    func getOptions()
    {
        BPProgressHUDManager.showKRProgressHUD(true)
        let URL = "\(APIName.APIFields)/\(selectedOption)"
        BPAPIManager.manager.getAPI(APIName: URL, params:[:], success: { (response) in
            DispatchQueue.main.async {
                debugPrint(response.count)
                let appDataRes = Mapper<BPResponse>().map(JSON: response)
                debugPrint(appDataRes!)
                self.field = appDataRes?.result?.fields ?? [BPFields()]
                self.setTable()
                self.title = appDataRes?.result?.screen_title
                BPProgressHUDManager.showKRProgressHUD(false)
            }
        }) { (error) in
            DispatchQueue.main.async {
                BPProgressHUDManager.showKRProgressHUD(false)
            }
        }
    }
}
extension BPPaymentDetailController : UITableViewDelegate , UITableViewDataSource
{
    //MARK: Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return field.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.FieldsCell, for: indexPath) as? BPFieldsTableCell
        {
            cell.field = self.field[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
extension BPPaymentDetailController
{
    func validateInput()
    {
        
        let countRowsOne = fieldsTable.numberOfRows(inSection: 0)
        for idx in 0...countRowsOne {
            let indexPath = IndexPath(row: idx, section: 0)
            if let cell = fieldsTable.cellForRow(at: indexPath) as? BPFieldsTableCell
            {
                let myViews = cell.fieldStack.arrangedSubviews
                for (_, view) in myViews.enumerated()
                {
                    if let textfield = view as? UITextField , (self.field[idx].is_mandatory != nil) == true
                    {
                        
                        if (textfield.text?.trim.count == 0)
                        {
                            self.showAlert(title: Strings.AlertTitle, message: Strings.MandatoryFields)
                            return
                        }
                        else if (self.field[idx].regex?.trim.count != 0)
                        {
                            let regx = self.field[idx].regex ?? ""
                            
                            let validate = (self.checkRegxValidation(regex: regx, textfieldValue: textfield.text ?? ""))
                            if (!validate)
                            {
                                self.showAlert(title: Strings.AlertTitle, message: "\(Strings.NotValid) \(self.field[idx].placeholder ?? "details")")
                                return
                                
                            }
                        }
                    }
                }
            }
        }
    }
}
