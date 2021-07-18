//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 島田岳 on R 3/07/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    
    var image1: UIImage!
    var image2: UIImage!
    var image3: UIImage!
    var count = 0
    var countFlag: Bool!
    
    // タイマー
    var timer: Timer!

    // タイマー用の時間のための変数
    var timer_sec: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        image1 = UIImage(named: "image1")
        image2 = UIImage(named: "image2")
        image3 = UIImage(named: "image3")
        playButton.setTitle("再生", for: .normal)
        
        self.imageButton.setImage(image1, for: .normal)
    }
    
    @IBAction func nextTap(_ sender: Any) {
        self.countFlag = true
        switchImage()
    }
    
    @IBAction func returnTap(_ sender: Any) {
        self.countFlag = false
        switchImage()
    }
    
    @IBAction func playTap(_ sender: Any) {
        if self.playButton.currentTitle == "再生"{
            playButton.setTitle("停止", for: .normal)
            returnButton.isEnabled = false
            nextButton.isEnabled = false
            self.countFlag = true
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(switchImage), userInfo: nil, repeats: true)
            
        } else{
            playButton.setTitle("再生", for: .normal)
            returnButton.isEnabled = true
            nextButton.isEnabled = true
            
            self.timer.invalidate()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているimageに値を代入して渡す
        //resultViewController.image = self.imageButton.image(for: .normal)
        resultViewController.image = self.imageButton.imageView?.image
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
    }
    
    @objc func switchImage() {
        if self.countFlag == true{
            if self.count == 2 {
                self.count = 0
            }else{
                self.count += 1
            }
        } else {
            if self.count == 0 {
                self.count = 2
            }else{
                self.count -= 1
            }
        }
        
        if self.count == 0{
            self.imageButton.setImage(image1, for: .normal)
        }else if self.count == 1{
            self.imageButton.setImage(image2, for: .normal)
        }else if self.count == 2{
            self.imageButton.setImage(image3, for: .normal)
        }
    }
    
}

