//
//  ViewController.swift
//  Project1
//
//  Created by Shilpa Joy on 2021-03-07.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recommend App", style: .plain, target: self, action: .none)
        title = "Storm Viewer"
        
        DispatchQueue.global(qos: .userInitiated).async {
        let fm = FileManager.default // FileManager.default. This is a data type that lets us work with the filesystem
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                self.pictures.append(item)
            }
        }
            self.pictures = self.pictures.sorted()
       
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.font = UIFont.init(name: "Helvetica", size: 20)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.totalPictures = pictures.count
           // vc.imageIndex = find(searchValue: pictures[indexPath.row], pictureArray: pictures)
            vc.imageIndex = indexPath.row
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    /*func find(searchValue: String, pictureArray: [String]) -> Int{
        
        for(index, value) in pictures.enumerated() {
            if value == searchValue {
                return index
            }
            
        }
return 0
    }*/

}

