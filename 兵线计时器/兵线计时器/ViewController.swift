//
//  ViewController.swift
//  兵线计时器
//
//  Created by 王硕 on 2017/12/24.
//  Copyright © 2017年 王硕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var nextTime: UILabel!

    @IBOutlet weak var gameTime: UILabel!
    
    @IBOutlet weak var dragon: UILabel!
    
    @IBOutlet weak var dragonStepper: UIStepper!
    var dragonCount = 0
    var timer : Timer!
    
    @IBAction func onClick(_ sender: Any) {
        addTime(secounds: -time)
        dragon.text = "0"
        dragonCount = 0
        dragonStepper.value = 0
        if (timer != nil){
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    var time = 0
    
    func addTime(secounds: Int) {
        time += secounds
        if(time <= 10) {
            nextTime.text = String(Int(10 - time))
        } else {
            nextTime.text = String(Int(33.25 - Double(Double(time) - 10.0 + 6.75 * Double(dragonCount)).truncatingRemainder(dividingBy: 33.25)))
        }
        gameTime.text = getFormatTime(secounds: TimeInterval(time))
    }
    
    func tick(){
        addTime(secounds: 1)
    }
    
    @IBAction func onAddClick(_ sender: Any) {
        addTime(secounds: 1)
    }
    
    @IBAction func onReduceClick(_ sender: Any) {
        addTime(secounds: -1)
    }
    
    @IBAction func onDragon(_ sender: UIStepper) {
        dragonCount = Int(sender.value)
        dragon.text = String(dragonCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFormatTime(secounds:TimeInterval)->String{
        if secounds.isNaN{
            return "00:00"
        }
        var Min = Int(secounds / 60)
        let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
        var Hour = 0
        if Min>=60 {
            Hour = Int(Min / 60)
            Min = Min - Hour*60
            return String(format: "%02d:%02d:%02d", Hour, Min, Sec)
        }
        return String(format: "00:%02d:%02d", Min, Sec)
    }

}

