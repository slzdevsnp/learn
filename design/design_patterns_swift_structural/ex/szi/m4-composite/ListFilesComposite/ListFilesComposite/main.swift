//
//  main.swift
//  ListFilesComposite
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation


private func printHeader(_ label: String){
    print("\n***********************************************")
    print("\(label)")
    print("***********************************************\n")
}


printHeader(" *contents of directory  no composite used")

var parentDir = Directory(name: "Music")
var subDir1 = Directory(name: "Red Hot Chili Peppers - Greatest Hits")
parentDir.add(entry: subDir1)
// files
var file11 = File(name: "Parallel Universe.mp3")
subDir1.add(entry: file11)
var file12 = File(name: "Dani California.mp3")
subDir1.add(entry: file12)
var file13 = File(name: "By The Way.mp3")
subDir1.add(entry: file13)
var file14 = File(name: "Love Rollercoaster.mp3")
subDir1.add(entry: file14)
var file15 = File(name: "Aeroplane.mp3")
subDir1.add(entry: file15)
var file16 = File(name: "Under The Bridge.mp3")
subDir1.add(entry: file16)
var file17 = File(name: "Road Trippin'.mp3")
subDir1.add(entry: file17)
var file18 = File(name: "The Zephyr Song.mp3")
subDir1.add(entry: file18)
var file19 = File(name: "Otherside.mp3")
subDir1.add(entry: file19)
var file20 = File(name: "Dosed.mp3")
subDir1.add(entry: file20)

var subDir2 = Directory(name: "Muse")
parentDir.add(entry: subDir2)
var subDir21 = Directory(name: "The 2nd Law")
subDir2.add(entry: subDir21)
// files
var file211 = File(name: "Supremacy.mp3")
subDir21.add(entry: file211)
var file212 = File(name: "Madness.mp3")
subDir21.add(entry: file212)
var file213 = File(name: "Panic Station.mp3")
subDir21.add(entry: file213)
var file214 = File(name: "Prelude.mp3")
subDir21.add(entry: file214)
var file215 = File(name: "Survival.mp3")
subDir21.add(entry: file215)

var subDir22 = Directory(name: "Drones")
subDir2.add(entry: subDir22)
// files
var file221 = File(name: "Dead Inside.mp3")
subDir22.add(entry: file221)
var file222 = File(name: "Aftermath.mp3")
subDir22.add(entry: file222)
var file223 = File(name: "Drones.mp3")
subDir22.add(entry: file223)
var file224 = File(name: "Mercy.mp3")
subDir22.add(entry: file224)

print(parentDir)


printHeader(" *contents of directory  using Composite ")

var c_parentDir = CDirectory(name: "Music")
var c_subDir1 = CDirectory(name: "Red Hot Chili Peppers - Greatest Hits")
c_parentDir.add(entry: c_subDir1)
// c_files
var c_file11 = CFile(name: "Parallel Universe.mp3")
c_subDir1.add(entry: c_file11)
var c_file12 = CFile(name: "Dani California.mp3")
c_subDir1.add(entry: c_file12)
var c_file13 = CFile(name: "By The Way.mp3")
c_subDir1.add(entry: c_file13)
var c_file14 = CFile(name: "Love Rollercoaster.mp3")
c_subDir1.add(entry: c_file14)
var c_file15 = CFile(name: "Aeroplane.mp3")
c_subDir1.add(entry: c_file15)
var c_file16 = CFile(name: "Under The Bridge.mp3")
c_subDir1.add(entry: c_file16)
var c_file17 = CFile(name: "Road Trippin'.mp3")
c_subDir1.add(entry: c_file17)
var c_file18 = CFile(name: "The Zephyr Song.mp3")
c_subDir1.add(entry: c_file18)
var c_file19 = CFile(name: "Otherside.mp3")
c_subDir1.add(entry: c_file19)
var c_file20 = CFile(name: "Dosed.mp3")
c_subDir1.add(entry: c_file20)

var c_subDir2 = CDirectory(name: "Muse")
c_parentDir.add(entry: c_subDir2)
var c_subDir21 = CDirectory(name: "The 2nd Law")
c_subDir2.add(entry: c_subDir21)
// c_files
var c_file211 = CFile(name: "Supremacy.mp3")
c_subDir21.add(entry: c_file211)
var c_file212 = CFile(name: "Madness.mp3")
c_subDir21.add(entry: c_file212)
var c_file213 = CFile(name: "Panic Station.mp3")
c_subDir21.add(entry: c_file213)
var c_file214 = CFile(name: "Prelude.mp3")
c_subDir21.add(entry: c_file214)
var c_file215 = CFile(name: "Survival.mp3")
c_subDir21.add(entry: c_file215)

var c_subDir22 = CDirectory(name: "Drones")
c_subDir2.add(entry: c_subDir22)
// c_files
var c_file221 = CFile(name: "Dead Inside.mp3")
c_subDir22.add(entry: c_file221)
var c_file222 = CFile(name: "Aftermath.mp3")
c_subDir22.add(entry: c_file222)
var c_file223 = CFile(name: "Drones.mp3")
c_subDir22.add(entry: c_file223)
var c_file224 = CFile(name: "Mercy.mp3")
c_subDir22.add(entry: c_file224)

print(c_parentDir)

