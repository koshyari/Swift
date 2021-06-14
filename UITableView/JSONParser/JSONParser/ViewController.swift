//
//  ViewController.swift
//  JSONParser
//
//  Created by Anshul Singh Koshyari on 08/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var result: [Dish]?
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return result?[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = result {
            return result[section].batters?.batter?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = result?[indexPath.section].batters?.batter?[indexPath.row].type
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
    
    //Collect JSON Data
    private func parseJSON() {
        let url = URL(string: "https://jsonkeeper.com/b/6CG9")
        
        URLSession.shared.dataTask(with: url!) {data, response, error in
            if error == nil && data != nil {
                //Parse JSON
                
                do {
                    self.result = try JSONDecoder().decode([Dish].self, from: data!)
                    //print(self.result!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error in JSON Parsing")
                }
            }
            
        }.resume()
    }
    
    
    
}

