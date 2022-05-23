//
//  UserData.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import Foundation
import UIKit

class UserData {
    let encoder = JSONEncoder()
        let allPatterns = "allPatterns"
    
    let defaults = UserDefaults.standard
    
    init() {
        
        do {
            defaults.register(
                defaults: [
                    allPatterns: try encoder.encode([
                        PatternModel(id: 0, name: "Padrao 01", isActive: true, colors: [ColorModel(color: UIColor.red), ColorModel(color: UIColor.green), ColorModel(color: UIColor.blue), ColorModel(color: UIColor.yellow), ColorModel(color: UIColor.purple)]),
                        PatternModel(id: 1, name: "Padrao 02", isActive: false, colors: [ColorModel(color: UIColor.brown), ColorModel(color: UIColor.gray), ColorModel(color: UIColor.red), ColorModel(color: UIColor.cyan)]),
                        PatternModel(id: 2, name: "Padrao 03", isActive: false, colors: [ColorModel(color: UIColor.orange), ColorModel(color: UIColor.magenta), ColorModel(color: UIColor.white)]),
                    ]),
                ]
            )
        } catch {
            print("Unable to Encode active pattern (\(error))")
        }
    }
    
    func reset() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func getActivePattern() -> PatternModel? {
        let patterns = getAllPatterns()
        
        let pattern = patterns?.first(where: { $0.isActive })
        
        return pattern
    }
    
    func deletePattern(id: Int) -> Void {
        var patterns = getAllPatterns()
        
        patterns?.removeAll(where: { pattern in
            pattern.id == id
        })
        
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(patterns)
            
            UserDefaults.standard.set(data, forKey: allPatterns)
            
        } catch {
            print("Unable to Encode Array of patterns (\(error))")
        }
    }
    
    func addPattern(id: Int, value: PatternModel) {
        var patterns = [PatternModel]()
        let pattern = getPatternById(id: id)
        
        if pattern == nil {
            patterns.append(value)
        } else {
            patterns.removeAll(where: { savedPatterns in
                savedPatterns.id == id
            })
            
            patterns.append(value)
        }
        
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(patterns)
            
            UserDefaults.standard.set(data, forKey: allPatterns)
            
        } catch {
            print("Unable to Encode Array of patterns (\(error))")
        }
    }
    
    func getAllPatterns() -> [PatternModel]? {
        var patterns: [PatternModel]?
        
        if let data = defaults.data(forKey: allPatterns) {
            do {
                let decoder = JSONDecoder()
                
                patterns = try decoder.decode([PatternModel].self, from: data)
                
            } catch {
                print("Unable to Decode all patterns (\(error))")
            }
        }
        
        return patterns
    }
    
    func getPatternById(id: Int) -> PatternModel? {
        let patterns = getAllPatterns()
        if (patterns == nil) {
            return nil
        }
        
        return patterns!.first(where: { savedPatterns in
            savedPatterns.id == id
        })
    }
}
