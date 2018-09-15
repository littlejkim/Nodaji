//
//  SellLayoutController.swift
//  Nodaji
//
//  Created by 김영도 on 15/08/2018.
//  Copyright © 2018 Nodaji. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class SellLayoutController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
 
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var deliveryFeeField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var SelectedAssets = [PHAsset]()
    var productImages: [UIImage] = []

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SellCollectionViewCell
        
        cell.productImageView.image = productImages[indexPath.item]
        return cell
    }
    
    
    @IBAction func uploadImage(_ sender: UIButton) {
        
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            print("Finish: \(assets)")
            print(assets.count)
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
                print(self.SelectedAssets)
                self.getAllImages()
            }

        }, completion: self.imageCollectionView.reloadData)
        
    }
    
    func getAllImages() -> Void {
        print("Assets to images")
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
                print(i)
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 75, height: 75), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                productImages.append(thumbnail)
                
            }
        }
        

    }

    let brands = ["Balenciaga", "Gucci", "Versace", "Givenchy", "Other"]
    
    var selectedBrand: String?
    override func viewWillAppear(_ animated: Bool) {
        brandField.tintColor = .clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
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
