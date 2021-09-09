//
//  VideosTableViewController.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/9/3.
//

import UIKit

class VideosTableViewController: UITableViewController {
    
    let datas = ["https://mim-img3.cctv.cn/video/720p/3d78fe6326474775bc789c87dfbbf0c4/TRANSCODE_1615269129757/26c28f75-df67-487b-ae03-373ba025c20e.mp4","https://mim-img3.cctv.cn/video/720p/16e424708f494acd9d066b38924a4440/TRANSCODE_1615269129757/a657cf21-cb5e-4cd1-bb71-f173c98403df.mp4","https://mim-img3.cctv.cn/video/720p/503867b47d7045c3a4d17fd897e80b76/TRANSCODE_1615269129757/cb9dcae2-d688-40ce-95f6-ca5fa211600c.mp4","https://mim-img3.cctv.cn/video/720p/d920ddafb45b4ebabade4e150d6b06df/TRANSCODE_1615269129757/a15153e9-9203-4f0f-9c5e-104764ff7bdd.mp4","https://mim-img3.cctv.cn/video/720p/3d78fe6326474775bc789c87dfbbf0c4/TRANSCODE_1615269129757/26c28f75-df67-487b-ae03-373ba025c20e.mp4","https://mim-img3.cctv.cn/video/720p/16e424708f494acd9d066b38924a4440/TRANSCODE_1615269129757/a657cf21-cb5e-4cd1-bb71-f173c98403df.mp4","https://mim-img3.cctv.cn/video/720p/503867b47d7045c3a4d17fd897e80b76/TRANSCODE_1615269129757/cb9dcae2-d688-40ce-95f6-ca5fa211600c.mp4","https://mim-img3.cctv.cn/video/720p/d920ddafb45b4ebabade4e150d6b06df/TRANSCODE_1615269129757/a15153e9-9203-4f0f-9c5e-104764ff7bdd.mp4","https://mim-img3.cctv.cn/video/720p/3d78fe6326474775bc789c87dfbbf0c4/TRANSCODE_1615269129757/26c28f75-df67-487b-ae03-373ba025c20e.mp4","https://mim-img3.cctv.cn/video/720p/16e424708f494acd9d066b38924a4440/TRANSCODE_1615269129757/a657cf21-cb5e-4cd1-bb71-f173c98403df.mp4","https://mim-img3.cctv.cn/video/720p/503867b47d7045c3a4d17fd897e80b76/TRANSCODE_1615269129757/cb9dcae2-d688-40ce-95f6-ca5fa211600c.mp4","https://mim-img3.cctv.cn/video/720p/d920ddafb45b4ebabade4e150d6b06df/TRANSCODE_1615269129757/a15153e9-9203-4f0f-9c5e-104764ff7bdd.mp4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
