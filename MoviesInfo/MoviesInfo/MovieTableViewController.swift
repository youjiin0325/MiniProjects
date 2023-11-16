//
//  MovieTableViewController.swift
//  MoviesInfo
//
//  Created by YOU on 11/16/23.
//

import UIKit

class MovieTableViewController: UITableViewController ,
                                UISearchBarDelegate, UISearchResultsUpdating {
    

    @IBOutlet var tbListView: UITableView!
    
    //테이블 목록
    var moviewTitles = [String]()
    var movieImages = [String]()
    var webAddresses = [String]()
    
    //UISearchContoller 인스턴스 및 일치하는 검색 결과가 저장될 배열 추가
    var searching = false //검색중인지 아닌지 판별
    var matchingItems = [Int]()
    var searchingContoller = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        initialize()
    }
    
    func  initialize () {
        moviewTitles = ["마녀 배달부 키키",
                       "마루 밑 아리에티",
                       "바람이 분다",
                       "이웃집 토토로",
                       "추억의 마니"]
        
        movieImages = ["마녀 배달부 키키.jpeg",
                       "마루 밑 아리에티.jpeg",
                       "바람이 분다.jpeg",
                       "이웃집 토토로.jpeg",
                       "추억의 마니.jpeg"]
        
        webAddresses = ["https://ko.wikipedia.org/wiki/마녀_배달부_키키",
                        "https://ko.wikipedia.org/wiki/마루_밑_아리에티",
                        "https://ko.wikipedia.org/wiki/바람이_분다_(영화)",
                        "https://ko.wikipedia.org/wiki/이웃집_토토로",
                        "https://ko.wikipedia.org/wiki/추억의_마니"]
        
        
        
        // 테이블 뷰의 예상 행 높이 설정
        // 테이블 보기 탐색을 추가할 때 행 높이가 축소되는 것을 방지하고, 테이블 렌더링 성능도 향상
        self.tableView.estimatedRowHeight = 50
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        //검색 초기화 :  UISearchBarDelegate, UISearchResultsUpdating
        //테이블 보기 컨트롤러 인스턴스를 검색 컨트롤러에 대한 검색창 및 결과를 업데이트 위임지로 지정
        searchingContoller.searchBar.delegate = self
        searchingContoller.searchResultsUpdater = self
        searchingContoller.searchBar.placeholder = "영화를 검색하세요"
        
        //검색으로 인해 검색 결과 보기 컨트롤러가 모호해지는 것을 방지하기 위한 속성을 설정
        searchingContoller.obscuresBackgroundDuringPresentation = false
        
        
        
        
    }
     //* 검색결과 업데이트 , 검새창에 입력된 텍스트가 포한된 검색 컨트롤러 개체에 대한 참조가 전달됨.
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    //* 검색 취소 버튼 처피(검색적용)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     
    }
    
    
    //* 뷰가 보일때마다 리스트의 데이터 다시 불러오기
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    // MARK: - Table view data source

    //* 테이블 안에 섹션이 1개
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //* 섹션별 행의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    //*items 값을 셀에 추가
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 'AttractionTableCell' 부분은 스토리보드 화면에서 테이블 뷰 셀'Table View Cell' 의 Identifier 에 넣은 이름으로 채움
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowMovieDetails", for: indexPath) as! MovieTableViewCell

        //사용자가 현재 검색중인 matches 배열에 대한 인덱스 값에서 가져와야 함
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    // Override to support editing the table view.
    //목록 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }


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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    

}
