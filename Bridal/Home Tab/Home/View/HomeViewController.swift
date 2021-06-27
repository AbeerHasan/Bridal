//
//  HomeViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 27/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories.append(Category(title: "Beauty Center", supTitle: "Sub Title", image: #imageLiteral(resourceName: "beauty centers")))
        categories.append(Category(title: "Buffet Services", supTitle: "Sub Title", image: #imageLiteral(resourceName: "Pofieh Services")))
        categories.append(Category(title: "Car Rental", supTitle: "Sub Title", image: #imageLiteral(resourceName: "car rent")))
        categories.append(Category(title: "Cosmetic Dentistry", supTitle: "Sub Title", image: #imageLiteral(resourceName: "toath beauty center")))
        categories.append(Category(title: "Domestic Flights", supTitle: "Sub Title", image: #imageLiteral(resourceName: "inner honey moon tourse")))
        categories.append(Category(title: "Flowers", supTitle: "Sub Title", image: #imageLiteral(resourceName: "flowers")))
        categories.append(Category(title: "Gold and Gewelry", supTitle: "Sub Title", image: #imageLiteral(resourceName: "Gold and Gueleries")))
        categories.append(Category(title: "Health and Beauty", supTitle: "Sub Title", image: #imageLiteral(resourceName: "Health and beauty")))
        categories.append(Category(title: "Honey Moon", supTitle: "Sub Title", image: #imageLiteral(resourceName: "Honey moon")))
        categories.append(Category(title: "Hotels", supTitle: "Sub Title", image: #imageLiteral(resourceName: "Hotels")))
        categories.append(Category(title: "Watches and Accessories", supTitle: "Sub Title", image: #imageLiteral(resourceName: "accessories and watches")))
        categories.append(Category(title: "Wedding Group", supTitle: "Sub Title", image: #imageLiteral(resourceName: "pands")))
        categories.append(Category(title: "DJ Services", supTitle: "Sub Title", image: #imageLiteral(resourceName: "DJ Organiser")))
        categories.append(Category(title: "Wedding Suits", supTitle: "Sub Title", image: #imageLiteral(resourceName: "wedding suits")))
        categories.append(Category(title: "Wedding Dresses", supTitle: "Sub Title", image: #imageLiteral(resourceName: "wedding drresses")))
        categories.append(Category(title: "Wedding Halls", supTitle: "Sub Title", image: #imageLiteral(resourceName: "wedding holes")))
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoriesTableViewCell else {return UITableViewCell()}
        cell.configurCell(category: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.categoriesTableView.frame.height / 6
    }
}
