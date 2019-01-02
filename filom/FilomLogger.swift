//
//  FilomLogger.swift
//  filom
//
//  Created by Bastien Beurier on 1/2/19.
//  Copyright © 2019 Bastien Beurier. All rights reserved.
//

import UIKit

class FilomLogger: NSObject {
    
    let logfileName = "filom"
    let logfileExtension = "csv"
    
    func logToLine(writeString: String) {
        let url = fileURL(fileName: logfileName, fileExtension: logfileExtension)
        do {
            try appendToURL(writeString: writeString + "\n", fileURL: url)
        } catch let error {
            print ("Failed writing to URL: \(fileURL), Error:" + error.localizedDescription)
        }
    }
}

extension FilomLogger {
    var DocumentDirURL: URL {
        let url = try! FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return url
    }
    
    func fileURL(fileName: String, fileExtension: String)-> URL{
        return DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    }
    
    func appendToURL(writeString: String, fileURL: URL) throws {
        let data = writeString.data(using: String.Encoding.utf8)!
        try append(writeData: data, fileURL: fileURL)
    }
    
    func append(writeData: Data, fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(writeData)
        }
        else {
            let mutableData = NSMutableData(data: firstCsvLine().data(using: String.Encoding.utf8)!)
            mutableData.append(writeData)
            try mutableData.write(to: fileURL, options: .atomic)
        }
    }
    
    func firstCsvLine() -> String {
        let maxViewCount = 5
        var result = "screen"
        
        for i in 1...maxViewCount {
            result += ",view\(i),view\(i)X,view\(i)Y,view\(i)W,view\(i)H"
        }
        
        return result + "\n"
    }
}
