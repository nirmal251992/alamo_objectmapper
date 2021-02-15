//
//  ViewController.swift
//  apiAlamofireObjctmapper
//
//  Created by Nirmal on 15/02/21.
//  Copyright © 2021 Nirmal. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    var model : Model_base?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tbl.tableFooterView = UIView()
    }
    
    func fetchData() {
        
        AF.request(Constants.sharedInstance.url,method: .get).responseJSON { (response) in
            
            switch response.result
            {
            case .success(let value):
                self.model = Mapper<Model_base>().map(JSONObject: value)
                DispatchQueue.main.async {
                     self.tbl.reloadData()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.lbl_email.text = model?.data?[indexPath.row].email
        return cell
    }
    
    
}
