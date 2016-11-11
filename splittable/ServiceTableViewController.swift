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
import SafariServices

class ServiceTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var services = [Service]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadServices()
    }
    
    func loadServices() {
        let apiURL = "https://sheetsu.com/apis/v1.0/aaf79d4763af"
        
        Alamofire.request(apiURL).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                self.parse(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parse(json: JSON) {
        for item in json.arrayValue {
            let sortOrder = item["sort_order"].stringValue
            let name = item["name"].stringValue
            let url = item["url"].stringValue
            let imageURL = item["image_url"].stringValue
            let serviceObject = Service(sortOrder: sortOrder, name: name, url: url, imageURL: imageURL)
            
            services.append(serviceObject)
        }
        
        services = services.sorted { $0.sortOrder < $1.sortOrder }
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
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
        let service = services[indexPath.row]
        
        if service.url.isEmpty {
            let cellIdentifier = "BannerTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServiceTableViewCell
            
            cell.photoImageView.sd_setImage(with: URL(string: service.imageURL))
            
            return cell
        } else {
            let cellIdentifier = "ServiceTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServiceTableViewCell
            
            cell.nameLabel.text = service.name
            cell.photoImageView.sd_setImage(with: URL(string: service.imageURL))
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        
        openURL(urlString: service.url)
    }
    
    func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            present(vc, animated: true)
        }
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
