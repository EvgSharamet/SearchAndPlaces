//
//  SearchController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 10.11.2021.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UITableViewController {
    
    //MARK: - data
    
    var onItemSelectedDelegate : ((String) -> Void)?
    var Cities = [ "Алушта", "Феодосия", "Ялта", "Севастополь", "Симферополь", "Абакан","Адлер", "Анапа", "Ангарск","Архангельск","Астрахань","Барнаул","Белгород","Благовещенск","Чебоксары","Челябинск","Череповец","Черняховск","Чита","Екатеринбург","Геленджик","Иркутск","Ижевск","Кабардинка","Калининград","Казань","Кемерово","Хабаровск","Ханты-Мансийск","Кисловодск","Кострома","Москва","Новосибирск", "Кипр"]
    var filteredCities: [String] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var mainView: UIView?
    private let identifier = "TableViewCell"
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        setupSearchView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch tableView {
       case self.tableView:
          return self.filteredCities.count
        default:
          return 0
       }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.filteredCities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemSelectedDelegate?(filteredCities[indexPath.row])
    }
    
    //MARK: - private functions
    
    func setupSearchView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        view.addSubview(searchController.searchBar)
        navigationItem.title  = "Weather"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.backgroundColor = .systemGroupedBackground
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    //MARK: - internal functions
    
    func updateSearchResults(for searchController: UISearchController) {
        if ((searchController.searchBar.text!.isEmpty)) {
            return
        }
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String ) {
        filteredCities = Cities.filter { (city: String) -> Bool in
            return city.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

