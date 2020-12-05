//
//  BPFieldsTableCell.swift
//  BillPayment
//
//  Created by Hetal Patel on 04/12/20.
//

import UIKit

class BPFieldsTableCell: UITableViewCell {

    @IBOutlet weak var fieldStack: UIStackView!
    var pickerData: [String] = [String]()
    var textDropDown = UITextField()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        _ = self.fieldStack.subviews.map({ $0.removeFromSuperview() }) // this returns modified array

    }
    var field : BPFields? {
        didSet {
            self.setupCell()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func mergeAttributedString(firstAttributedString : NSMutableAttributedString, secondAttributedString : NSAttributedString) -> NSMutableAttributedString?
{
        firstAttributedString.append(secondAttributedString)
        return firstAttributedString
}
    func setPicker(_textfield : UITextField)
    {
        let dropDownPicker : UIPickerView = UIPickerView()
        _textfield.inputView = dropDownPicker
        dropDownPicker.delegate = self
        dropDownPicker.dataSource = self
       
    }
    func setupCell()
    {
        switch self.field?.ui_type?.type {
        case .DropdownType:
            let nameLabel = UILabel()
            nameLabel.backgroundColor = UIColor.white
            nameLabel.numberOfLines = 0
            nameLabel.lineBreakMode = .byWordWrapping
            nameLabel.textAlignment = .left
            nameLabel.attributedText = self.mergeAttributedString(firstAttributedString: NSMutableAttributedString(string: ("\(self.field?.placeholder ?? "") \("\n")")), secondAttributedString: (self.field?.hint_text ?? "").hintAttributeString() ?? NSMutableAttributedString())
            fieldStack.addArrangedSubview(nameLabel)
//            textDropDown = UITextField()
            textDropDown.backgroundColor = UIColor.white
            textDropDown.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
            textDropDown.placeholder  = self.field?.placeholder
            textDropDown.textAlignment = .left
            textDropDown.borderStyle = .roundedRect
            self.setPicker(_textfield: textDropDown)
            fieldStack.addArrangedSubview(textDropDown)
            break
        case .TextfieldType:
            
            let nameLabel = UILabel()
            nameLabel.backgroundColor = UIColor.white
            nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
            nameLabel.textAlignment = .left
            nameLabel.numberOfLines = 0
            nameLabel.lineBreakMode = .byWordWrapping
            nameLabel.attributedText = self.mergeAttributedString(firstAttributedString: NSMutableAttributedString(string: ("\(self.field?.placeholder ?? "") \("\n")")), secondAttributedString: (self.field?.hint_text ?? "").hintAttributeString() ?? NSMutableAttributedString())
            fieldStack.addArrangedSubview(nameLabel)
            
            let textLabel = UITextField()
            textLabel.backgroundColor = UIColor.white
            textLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
            textLabel.placeholder  = self.field?.placeholder
            textLabel.textAlignment = .left
            textLabel.borderStyle = .roundedRect
            fieldStack.addArrangedSubview(textLabel)
        break
        default:
            break
        }
    }
}
extension BPFieldsTableCell : UIPickerViewDelegate,UIPickerViewDataSource
{
    //MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.field?.ui_type?.values?.count ?? 0
    }
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.field?.ui_type?.values?[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textDropDown.text = self.field?.ui_type?.values?[row].name
    }
    
}
