//
//  SellLayoutController.swift
//  Nodaji
//
//  Created by 김영도 on 15/08/2018.
//  Copyright © 2018 Nodaji. All rights reserved.
//

import UIKit

class SellLayoutController: UIViewController, UIImagePickerControllerDelegate {
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var deliveryFeeField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    let imagepicker = UIImagePickerController()
    

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func uploadImage(_ sender: UIButton) {
        
    }
    
    
    let brands = ["Balenciaga", "Gucci", "Versace", "Givenchy", "Other"]
    
    var selectedBrand: String?
    override func viewWillAppear(_ animated: Bool) {
        brandField.tintColor = .clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createBrandPicker()
        createToolbar()
        print("Sell loaded")
    }
    
    func createBrandPicker() {
        let brandPicker = UIPickerView()
        brandPicker.delegate = self
        brandField.inputView = brandPicker
    }
    
    @objc
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SellLayoutController.dismissKeyboard))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SellLayoutController.cancelClick))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        brandField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func cancelClick() {
        brandField.resignFirstResponder()
    }
}

extension SellLayoutController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return brands.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return brands[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBrand = brands[row]
        brandField.text = selectedBrand
    }
}
