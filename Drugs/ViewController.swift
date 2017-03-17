//
//  ViewController.swift
//  Drugs
//
//  Created by IMAC-7 on 14/02/17.
//  Copyright © 2017 socet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class tblcell: UITableViewCell
{
    
    @IBOutlet weak var vw: UIView!
    @IBOutlet weak var lbl: UILabel!
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var tableview: UITableView!
     var dataArray = NSArray()
    override func viewDidLoad()
    {
        callLoginWebService()
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view, typically from a nib.
    }; func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArray.count)
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! tblcell
        let dic = dataArray[indexPath.row] as! NSDictionary
        cell.lbl.text! = (dic["ID"] as! String) + "  " + (dic["Name"] as! String)
        if indexPath.row % 2 == 1
        {
            cell.vw.backgroundColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
        }
        else
        {
            cell.vw.backgroundColor = UIColor.white
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       let obj = storyboard?.instantiateViewController(withIdentifier: "tabbar") as! tabbar
            let dic = dataArray[indexPath.row] as! NSDictionary
        id = dic["ID"] as! String
        
        hname = dic["Name"] as! String
        self.navigationController?.pushViewController(obj, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func callLoginWebService()
    {
        SVProgressHUD.show()
        Alamofire.request("http://shiv.890m.com/names.php", method: .get, parameters: nil, encoding: JSONEncoding.default)
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
              //  if (data == nil)
                //{
                  //  print("hello");
                    
                //}
                //else
                //{
                    data = response.result.value as! NSDictionary
                    print(data)
                    self.dataArray = data["drugs"] as! NSArray
                    self.tableview.reloadData()

               // }
                }
                
                
        
        
    }



}

