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

class SellLayoutController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
 
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var deliveryFeeField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var sizeField: UITextField!
    var SelectedAssets = [PHAsset]()
    var productImages: [UIImage] = []

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SellCollectionViewCell
        
        cell.productImageView.image = productImages[indexPath.row]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = imageCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = imageCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        
  
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            if(self.productImages.count == 0) {
                self.uploadButton.isHidden = false
            }
            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
            }
            self.getAllImages()
            DispatchQueue.main.async {
                self.imageCollectionView.isHidden = false
                self.uploadButton.isHidden = true
                print("Image collectionview reloaded")
                self.imageCollectionView?.reloadData()
            }
        }, completion: nil)
        
    }
    
    func getAllImages() -> Void {
        print("Number of images : " + String(SelectedAssets.count))
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
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

    @IBAction func resetButton(_ sender: UIButton) {
        
        SelectedAssets.removeAll()
        productImages.removeAll()
        DispatchQueue.main.async {
            print("Image collectionview reloaded")
            print("Number of images" + String(self.productImages.count))
            self.imageCollectionView.isHidden = true
            self.uploadButton.isHidden = false
            self.imageCollectionView?.reloadData()
        }
    }
    
    let brands = ["Balenciaga", "Gucci", "Versace", "Givenchy", "Other"]
    
    var selectedBrand: String?
    
    override func viewWillAppear(_ animated: Bool) {
        brandField.tintColor = .clear
        imageCollectionView.isHidden = true
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        print("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.reloadData()
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
