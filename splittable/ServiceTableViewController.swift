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
        
        if let savedServices = loadSavedServices() {
            services += savedServices
        } else {
            loadServices()
        }
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
        saveServices()
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // MARK: NSCoding
    
    func saveServices() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(services, toFile: Service.archiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save services...")
        }
    }
    
    func loadSavedServices() -> [Service]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Service.archiveURL.path) as? [Service]
    }

}
