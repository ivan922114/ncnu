//
//  TableViewController.swift
//  xmltest
//
//  Created by Seng Lam on 2018/4/10.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, XMLParserDelegate {

    var departmentID = ["中文系":"M100","外文系":"M200","社工系":"M400","公行系":"M500","歷史系":"M600","東南亞系":"M800","華文碩士學程":"MD00","非營利組織經營管理碩士學位學程":"MF00","原鄉發展學士專班":"MG00","國企系":"N100","經濟系":"N200","資管系":"N300","財金系":"N400","觀光餐旅系":"N500","管理學學位學程":"N600","新興產業策略與發展學位學程":"N800","土木系":"O100","資工系":"O200","電機系":"O300","應化系":"O400","應光系":"O800","國比系":"M300","教政系":"M700","諮人系":"MA00","課科所":"MC00","終身學習與人資專班":"ME00","其他":"U000"]
    
    var eName: String = String()
    var courses: [Course] = []
    var faculty: String = String()
    var year: String = String()
    var semester: String = String()
    var department: String = String()
    var edepartment: String? = String()
    var cousre_id: String = String()
    var `class`: String? = String()
    var course_cname: String = String()
    var course_ename: String? = String()
    var time: String = String()
    var location: String = String()
    var teacher: String = String()
    var eteacher: String? = String()
    var division: String = String()
    var edivision: String? = String()
    var course_credit: String = String()
    var apiUrl = "https://api.ncnu.edu.tw/API/get.aspx?xml=course_ncnu&year=106&semester=2&unitId="
    
//    func getCourses(apiUrl: String){
//        do{
//            let url = URL(string: apiUrl)
//            let data = try Data(contentsOf: url!)
//            let parser = XMLParser(data: data)
//            parser.delegate = self
//            parser.parse()
//        }catch{
//            print("error")
//        }
////        if let path = Bundle.main.url(forResource: "data", withExtension: "xml") {
////            if let parser = XMLParser(contentsOf: path) {
////                parser.delegate = self
////                parser.parse()
////            }
////        }
//    }
    
    func getCourses(apiUrl: String) {
        guard let apiUrl = URL(string: apiUrl) else {
            return
        }
        
        let request = URLRequest(url: apiUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                    let parser = XMLParser(data: data)
                    parser.delegate = self
                    parser.parse()
            
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
//        apiUrl += departmentID["外文系"]!
        getCourses(apiUrl: apiUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! coursesTableViewCell
        courses.sort(by: {$0.time < $1.time})
        let course = courses[indexPath.row]
        cell.teacher.text = course.teacher
//        cell.teacher.layer.borderWidth = 1
        cell.time.text = course.time
        cell.course.text = course.course_cname
        return cell
    }
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if eName == "item" {
             faculty = String()
             year = String()
             semester = String()
             department = String()
             edepartment? = String()
             cousre_id = String()
             `class`? = String()
             course_cname = String()
             course_ename? = String()
             time = String()
             location = String()
             teacher = String()
             eteacher? = String()
             division = String()
             edivision? = String()
             course_credit = String()
            
        }
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let course = Course()
            course.faculty = faculty
            course.year = year
            course.semester = semester
            course.department = department
            course.edepartment = edepartment
            course.cousre_id = cousre_id
            course.`class` = `class`
            course.course_cname = course_cname
            course.course_ename = course_ename
            course.time = time
            course.location = location
            course.teacher = teacher
            course.eteacher = eteacher
            course.division = division
            course.edivision = edivision
            course.course_credit = course_credit
            courses.append(course)
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            switch(eName){
            case "faculty":
                faculty += data
            case "year":
                year += data
            case "semester":
                semester += data
            case "department":
                department += data
            case "edepartment":
                edepartment? += data
            case "cousre_id":
                cousre_id += data
            case "class":
                `class`? += data
            case "course_cname":
                course_cname += data
            case "course_ename":
                course_ename? += data
            case "time":
                time += data
            case "location":
                location += data
            case "teacher":
                teacher += data
            case "eteacher":
                eteacher? += data
            case "division":
                division += data
            case "edivision":
                edivision? += data
            case "course_credit":
                course_credit += data
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourseDetails"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! courseDetailsViewController
                destinationController.navigationItem.title = courses[indexPath.row].course_cname
                destinationController.id = courses[indexPath.row].cousre_id
                destinationController.`class` = courses[indexPath.row].`class`!
            }
        }
    }
}
