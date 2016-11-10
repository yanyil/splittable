//
//  ServiceTableViewController.swift
//  splittable
//
//  Created by Yan-Yi Li on 10/11/2016.
//  Copyright © 2016 Yan-Yi Li. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class ServiceTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var services = [Service]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadServices()

    }
    
    func loadServices() {
        let url = "https://sheetsu.com/apis/v1.0/aaf79d4763af"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                for item in json.arrayValue {
                    let name = item["name"].stringValue
                    let imageURL = item["image_url"].stringValue
                    let serviceObject = Service(name: name, imageURL: imageURL)
                    self.services.append(serviceObject)
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ServiceTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServiceTableViewCell
        
        let service = services[indexPath.row]

        cell.nameLabel.text = service.name
        cell.photoImageView.sd_setImage(with: URL(string: service.imageURL))

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
