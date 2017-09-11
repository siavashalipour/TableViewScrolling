//
//  ViewController.swift
//  TableViewScrolling
//
//  Created by Siavash on 11/9/17.
//  Copyright © 2017 Siavash. All rights reserved.
//

import UIKit

let section1: Int = 0
let section2: Int = 45
let section3: Int = 75

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!

    
    var ds: [Int] = []
    var isTap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.setTitle("Special", for: .normal)
        btn2.setTitle("Eat", for: .normal)
        btn3.setTitle("Drink", for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        setupDS()
        btn1Tap(btn1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupDS() {
        ds = []
        for i in 0...100 {
            ds.append(i)
        }
        tableView.reloadData()
    }
    @IBAction func btn1Tap(_ sender: UIButton) {
        isTap = true
        btn1.backgroundColor = UIColor.blue
        btn2.backgroundColor = UIColor.clear
        btn3.backgroundColor = UIColor.clear
        tableView.scrollToRow(at: IndexPath.init(row: section1, section: 0), at: .top, animated: true)
    }
    @IBAction func btn2Tap(_ sender: UIButton) {
        isTap = true
        btn1.backgroundColor = UIColor.clear
        btn2.backgroundColor = UIColor.blue
        btn3.backgroundColor = UIColor.clear
        tableView.scrollToRow(at: IndexPath.init(row: section2, section: 0), at: .top, animated: true)
    }
    @IBAction func btn3Tap(_ sender: UIButton) {
        isTap = true
        btn1.backgroundColor = UIColor.clear
        btn2.backgroundColor = UIColor.clear
        btn3.backgroundColor = UIColor.blue
        tableView.scrollToRow(at: IndexPath.init(row: section3, section: 0), at: .top, animated: true)

    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCell
        if let aCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyCell {
            cell = aCell
        } else {
            cell = MyCell()
        }
        cell.config(with: ds[indexPath.row])
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTap = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isTap {
            if let indexes = tableView.indexPathsForVisibleRows {
                if indexes.first?.row == section1 {
                    btn1.backgroundColor = UIColor.blue
                    btn2.backgroundColor = UIColor.clear
                    btn3.backgroundColor = UIColor.clear
                    
                } else if indexes.first?.row == section2 {
                    btn1.backgroundColor = UIColor.clear
                    btn2.backgroundColor = UIColor.blue
                    btn3.backgroundColor = UIColor.clear
                } else if indexes.first?.row == section3 {
                    btn1.backgroundColor = UIColor.clear
                    btn2.backgroundColor = UIColor.clear
                    btn3.backgroundColor = UIColor.blue
                }
                if let last = indexes.last {
                    if last.row < section3 && last.row > section2 {
                        btn1.backgroundColor = UIColor.clear
                        btn2.backgroundColor = UIColor.blue
                        btn3.backgroundColor = UIColor.clear
                    } else if last.row < section2 {
                        btn1.backgroundColor = UIColor.blue
                        btn2.backgroundColor = UIColor.clear
                        btn3.backgroundColor = UIColor.clear
                    }
                }
                
            }
 
        }
    }
}

class MyCell: UITableViewCell {
    
    @IBOutlet weak var aLabel: UILabel!
    
    func config(with data: Int) {
        if data == section1 {
            aLabel.text = "Specials"
            contentView.backgroundColor = UIColor.lightGray

        } else if data == section2 {
            aLabel.text = "Eat"
            contentView.backgroundColor = UIColor.lightGray
        } else if data == section3 {
            aLabel.text = "Drink"
            contentView.backgroundColor = UIColor.lightGray
        } else {
            aLabel.text = "\(data)"
            contentView.backgroundColor = UIColor.white
        }
    }
}
