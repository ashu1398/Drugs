//
//  Contraindication.swift
//  Drugs
//
//  Created by IMAC-7 on 14/02/17.
//  Copyright © 2017 socet. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD

class Contraindication: UIViewController {
    
    @IBOutlet weak var clbl: UILabel!
    
    @IBAction func back(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var cont: UITextView!
var dataArray = NSArray()
    override func viewDidLoad()
    {
        callLoginWebService()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callLoginWebService()
    {
        SVProgressHUD.show()
        Alamofire.request("http://shiv.890m.com/contraindications.php?id=" + id , method: .get, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                
                return .success
            }
            .responseJSON { response in
                SVProgressHUD.dismiss()
                print(response)
                
                var data = NSDictionary()
                if (data == nil)
                {
                    print("hello");
                    
                }
                else
                {
                    data = response.result.value as! NSDictionary
                    print(data)
                    self.dataArray = data["drugs"] as! NSArray
                    let dic = self.dataArray[0]as! NSDictionary
                    self.clbl.text! = hname
                    self.cont.text! = dic["Contraindication"] as! String
                    
                }
        }
        
        
        
        
    }


}
