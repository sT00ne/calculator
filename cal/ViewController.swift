//
//  ViewController.swift
//  cal
//
//  Created by sT00nne on 1/5/15.
//  Copyright (c) 2015 冬. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    var oprand0 = [String]()
    var oprand1 = [String]()
    var oprator = [String]()
    var isequal:Bool = true
    var isnegative:Bool = false
    var isDot:Bool = false
    var isnegative2:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(sender: UIButton) {
       
        let defoprator = ["+","-","x","/"]
        let defoprand = ["0","1","2","3","4","5","6","7","8","9","."]
        var num = sender.currentTitle
        var isNum:Bool = false
        var isOp:Bool = false
        
        for a in defoprator{
            if a.hasSuffix(num!){
                isOp = true
            }
        }
        for a in defoprand{
            if a.hasSuffix(num!){
                isNum = true
            }
        }
        //输入数字
        if isNum {
            if isequal {
                if num! == "." {
                    if isDot {
                        return
                    } else {
                        if oprand0.count == 0 {
                            oprand0.append("0")
                        }
                        oprand0.append(num!)
                        oprand1 = [String]()
                        oprator = [String]()
                        isDot = true
                    }
                }
                else{
                    oprand1 = [String]()
                    oprator = [String]()
                    oprand0.append(num!)
                }
                var eq = join("", oprand0)
                result.text = "\(eq)"
            } else {
                if num! == "." {
                    if isDot {
                        return
                    } else {
                        if oprand1.count == 0{
                            oprand1.append("0")
                            oprand1.append(num!)
                        } else {
                            oprand1.append(num!)
                        }
                    }
                    isDot = true
                } else {
                    oprand1.append(num!)
                }
                var eq = join("", oprand1)
                result.text = "\(eq)"
            }
        }
        
        //输入运算符
        if isOp {
            if isequal {
                //前一次为输入等号
                if oprand0.count == 0{
                    //直接输入符号
                    oprand0.append("0")
                    oprator = [String]()
                }
                oprator.append(num!)
                var eq = join("", oprand0)
                if isnegative {
                    result.text = "-"+"\(eq)"
                } else {
                    result.text = "\(eq)"
                }
            } else {
                if oprand1.count == 0 && oprator.count != 0{
                    oprator.removeLast()
                    oprator.append(num!)
                } else if oprand1.count == 0 {
                    oprator.append(num!)
                } else {
                    var res:Double = 0.0
                    //数组转换为string
                    var num1 = join("", oprand0)
                    var num3:Double = 0
                    if isnegative {
                        num3 = -(num1 as NSString).doubleValue
                    } else {
                        num3 = (num1 as NSString).doubleValue
                    }
                    var num2 = join("", oprand1)
                    var num4:Double = 0
                    if isnegative2 {
                        num4 = -(num2 as NSString).doubleValue
                    } else {
                        num4 = (num2 as NSString).doubleValue
                    }
                    switch oprator[oprator.count-1]{
                    case "+" :
                        //加法
                            res = num3 + num4
                    case "x" :
                        //乘法
                            res = num3 * num4
                    case "-" :
                        //减法
                            res = num3 - num4
                    case "/" :
                        //除法
                            res = num3 / num4
                    default :
                        res = 0
                    }
                    //如果整数，删去小数点
                    var resint:Int = 0
                    if res >= 0{
                        isnegative = false
                    } else {
                        isnegative = true
                        res = -res
                    }
                    if res % 1.0 == 0 {
                        //整数的处理，结果存入数组op0
                        if isnegative{
                            result.text = "-"+"\(Int(res))"
                        } else {
                            result.text = "\(Int(res))"
                        }
                        resint = Int(res)
                        var temp = [String]()
                        while resint > 0{
                            temp.append(String(resint % 10))
                            resint = resint/10
                        }
                        var tempcount = temp.count - 1
                        oprand0 = [String]()
                        for tempcount ; tempcount >= 0 ; tempcount-- {
                            oprand0.append(temp[tempcount])
                        }
                    } else {
                        //小数的处理，存入数组op0
                        if isnegative{
                            result.text = "-"+"\(res)"
                        } else {
                            result.text = "\(res)"
                        }
                        var temp = [String]()
                        resint = Int(res)
                        var resdouble:Double = Double(res) - Double(resint)
                        while resint > 0{
                            temp.append(String(resint % 10))
                            resint = resint/10
                        }
                        var tempcount = temp.count - 1
                        oprand0 = [String]()
                        for tempcount; tempcount >= 0 ; tempcount-- {
                            oprand0.append(temp[tempcount])
                        }
                        oprand0.append(".")
                        
                        while resdouble > 0{
                            oprand0.append(String(Int(resdouble * 10)))
                            resdouble = resdouble * 10 % 1
                        }
                    }
                    //清空符号，添加一个这次输入的符号。
                    oprator = [String]()
                    oprator.append(num!)
                }
            }
            //清空op1，将是否为等号设置为false
            oprand1 = [String]()
            isequal = false
            isnegative2 = false
            isDot = false
        }
        
        
        if num == "=" {
            if isequal {
                //前一次为输入等号
                if oprand1.count != 0 {
                    //再算前一次的运算
                    var res:Double = 0.0
                    //数组转换为string
                    var num1 = join("", oprand0)
                    var num3:Double = 0
                    if isnegative {
                        num3 = -(num1 as NSString).doubleValue
                    } else {
                        num3 = (num1 as NSString).doubleValue
                    }
                    var num2 = join("", oprand1)
                    var num4:Double = 0
                    if isnegative2 {
                        num4 = -(num2 as NSString).doubleValue
                    } else {
                        num4 = (num2 as NSString).doubleValue
                    }
                    switch oprator[oprator.count-1]{
                    case "+" :
                        //加法
                        res = num3 + num4
                    case "x" :
                        //乘法
                        res = num3 * num4
                    case "-" :
                        //减法
                        res = num3 - num4
                    case "/" :
                        //除法
                        res = num3 / num4
                    default :
                        res = 0
                    }
                    //如果整数，删去小数点
                    var resint:Int = 0
                    if res >= 0{
                        isnegative = false
                    } else {
                        isnegative = true
                        res = -res
                    }
                    if res % 1.0 == 0 {
                        //整数的处理，结果存入数组op0
                        if isnegative{
                            result.text = "-"+"\(Int(res))"
                        } else {
                            result.text = "\(Int(res))"
                        }
                        resint = Int(res)
                        var temp = [String]()
                        while resint > 0{
                            temp.append(String(resint % 10))
                            resint = resint/10
                        }
                        var tempcount = temp.count - 1
                        oprand0 = [String]()
                        for tempcount ; tempcount >= 0 ; tempcount-- {
                            oprand0.append(temp[tempcount])
                        }
                    } else {
                        //小数的处理，存入数组op0
                        if isnegative{
                            result.text = "-"+"\(res)"
                        } else {
                            result.text = "\(res)"
                        }
                        var temp = [String]()
                        resint = Int(res)
                        var resdouble:Double = Double(res) - Double(resint)
                        while resint > 0{
                            temp.append(String(resint % 10))
                            resint = resint/10
                        }
                        var tempcount = temp.count - 1
                        oprand0 = [String]()
                        for tempcount; tempcount >= 0 ; tempcount-- {
                            oprand0.append(temp[tempcount])
                        }
                        oprand0.append(".")
                        
                        while resdouble > 0{
                            oprand0.append(String(Int(resdouble * 10)))
                            resdouble = resdouble * 10 % 1
                        }
                    }

                } else {
                    return
                }
            } else {
                if oprand1.count == 0 && oprator.count != 0{
                    oprand1 = oprand0
                }
                var res:Double = 0.0
                //数组转换为string
                var num1 = join("", oprand0)
                var num3:Double = 0
                if isnegative {
                    num3 = -(num1 as NSString).doubleValue
                } else {
                    num3 = (num1 as NSString).doubleValue
                }
                var num2 = join("", oprand1)
                var num4:Double = 0
                if isnegative2 {
                    num4 = -(num2 as NSString).doubleValue
                } else {
                    num4 = (num2 as NSString).doubleValue
                }
                switch oprator[oprator.count-1]{
                case "+" :
                    //加法
                    res = num3 + num4
                case "x" :
                    //乘法
                    res = num3 * num4
                case "-" :
                    //减法
                    res = num3 - num4
                case "/" :
                    //除法
                    res = num3 / num4
                default :
                    res = 0
                }
                //如果整数，删去小数点
                var resint:Int = 0
                if res >= 0{
                    isnegative = false
                } else {
                    isnegative = true
                    res = -res
                }
                if res % 1.0 == 0 {
                    //整数的处理，结果存入数组op0
                    if isnegative{
                        result.text = "-"+"\(Int(res))"
                    } else {
                        result.text = "\(Int(res))"
                    }
                    resint = Int(res)
                    var temp = [String]()
                    while resint > 0{
                        temp.append(String(resint % 10))
                        resint = resint/10
                    }
                    var tempcount = temp.count - 1
                    oprand0 = [String]()
                    for tempcount ; tempcount >= 0 ; tempcount-- {
                        oprand0.append(temp[tempcount])
                    }
                } else {
                    //小数的处理，存入数组op0
                    if isnegative{
                        result.text = "-"+"\(res)"
                    } else {
                        result.text = "\(res)"
                    }
                    var temp = [String]()
                    resint = Int(res)
                    var resdouble:Double = Double(res) - Double(resint)
                    while resint > 0{
                        temp.append(String(resint % 10))
                        resint = resint/10
                    }
                    var tempcount = temp.count - 1
                    oprand0 = [String]()
                    for tempcount; tempcount >= 0 ; tempcount-- {
                        oprand0.append(temp[tempcount])
                    }
                    oprand0.append(".")
                    
                    while resdouble > 0{
                        oprand0.append(String(Int(resdouble * 10)))
                        resdouble = resdouble * 10 % 1
                    }
                }
            }
            isequal = true
            isDot = false
        }
        
        if num == "+/-" {
            if result.text == "0" {
                return
            }
            else if isequal {
                var str:String = join("", oprand0)
                if isnegative {
                    isnegative = false
                    result.text = "\(str)"
                } else {
                    isnegative = true
                    result.text = "-"+"\(str)"
                }
            }
            else if oprator.count != 0 && oprand1.count != 0 {
                if isnegative2 {
                    isnegative2 = false
                    var eq = join("", oprand1)
                    result.text = "\(eq)"
                } else {
                    isnegative2 = true
                    var eq = join("", oprand1)
                    result.text = "-"+"\(eq)"
                }
            } else {
                if isnegative {
                    isnegative = false
                    var eq = join("", oprand0)
                    result.text = "\(eq)"
                } else {
                    isnegative = true
                    var eq = join("", oprand0)
                    result.text = "-"+"\(eq)"
                }
            }
        }
        
        if num == "C" {
            oprand0 = [String]()
            oprand1 = [String]()
            oprator = [String]()
            result.text = "0"
            isequal = true
            isnegative = false
            isnegative2 = false
        }
        
        if num == "%" {
            if isequal {
                var str:String = join("", oprand0)
                var str2 = (str as NSString).doubleValue / 100
                if isnegative {
                    result.text = "-"+"\(str2)"
                } else {
                    result.text = "\(str2)"
                }
                var resint:Int = 0
                if str2 % 1.0 == 0 {
                    //整数的处理，结果存入数组op0
                    if isnegative{
                        result.text = "-"+"\(Int(str2))"
                    } else {
                        result.text = "\(Int(str2))"
                    }
                    resint = Int(str2)
                    var temp = [String]()
                    while resint > 0{
                        temp.append(String(resint % 10))
                        resint = resint/10
                    }
                    var tempcount = temp.count - 1
                    oprand0 = [String]()
                    for tempcount ; tempcount >= 0 ; tempcount-- {
                        oprand0.append(temp[tempcount])
                    }
                } else {
                    //小数的处理，存入数组op0
                    if isnegative{
                        result.text = "-"+"\(str2)"
                    } else {
                        result.text = "\(str2)"
                    }
                    var temp = [String]()
                    resint = Int(str2)
                    var resdouble:Double = Double(str2) - Double(resint)
                    while resint > 0{
                        temp.append(String(resint % 10))
                        resint = resint/10
                    }
                    var tempcount = temp.count - 1
                    oprand0 = [String]()
                    for tempcount; tempcount >= 0 ; tempcount-- {
                        oprand0.append(temp[tempcount])
                    }
                    oprand0.append(".")
                    while resdouble > 0{
                        oprand0.append(String(Int(resdouble * 10)))
                        resdouble = resdouble * 10 % 1
                    }
                }
            } else {
                var str = join("",oprand1)
                var str2 = (str as NSString).doubleValue / 100
                if isnegative2 {
                    result.text = "-"+"\(str2)"
                } else {
                    result.text = "\(str2)"
                }
            }
        }

    }
}

