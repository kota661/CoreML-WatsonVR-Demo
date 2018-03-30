//
//  ClassificationViewController.swift
//  CoreML WatsonVR Demo
//
//  Created by Kota Sato on 2018/03/30.
//  Copyright © 2018 Kota Sato. All rights reserved.
//

import UIKit

class ClassifyViewController: UIViewController {

    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // カメラボタンが押されたら。
    @IBAction func takePicture(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)){
            // カメラが使える場合
            let picker = UIAlertController()
            picker.addAction(_makePickAction(title: "カメラで撮影する", sourceType: .camera))
            picker.addAction(_makePickAction(title: "ライブラリから選択する", sourceType: .photoLibrary))
            picker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(picker, animated: true)
        } else {
            // カメラが使えない場合
            _pick(sourceType: .photoLibrary)
        }
    }
    
    // ActionSheetに表示するアクションの作成
    func _makePickAction(title: String, sourceType: UIImagePickerControllerSourceType) -> UIAlertAction{
        return UIAlertAction(title: title, style: UIAlertActionStyle.default, handler: {
        (action: UIAlertAction!) in
            // ボタンが押されたら
            self._pick(sourceType: sourceType)
        })
    }
    
    // 写真の選択・撮影
    func _pick(sourceType: UIImagePickerControllerSourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension ClassifyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: true)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = image
        print("done")
    }
}


