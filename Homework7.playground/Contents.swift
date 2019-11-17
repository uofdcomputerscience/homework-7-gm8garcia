  
import Foundation

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.
// MARK: - STEP ONE
// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.
struct Book: Codable {
    var title: String
    var author: String
    var pubYear: String
    var image: String
}
// MARK: - STEP TWO
// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.
var Books: [Book] = []
let PercyJackson = Book(title: "Percy Jackson and the Lightning Thief", author: "Rick Riordan", pubYear: "2005", image: ".")
let Wonder = Book(title: "Wonder", author: "R.J. Palacio", pubYear: "2012", image: ".")
let TheSelection = Book(title: "TheSelection", author: "Kiera Cass", pubYear: "2012", image: ".")
let ToAllTheBoys = Book(title: "To All the Boys I've Loved Before", author: "Jenny Han", pubYear: "2014", image: ".")
let TheGiver = Book(title: "The Giver", author: "Lowis Lowry", pubYear: "1993", image: "." )

Books.append(PercyJackson)
Books.append(Wonder)
Books.append(TheSelection)
Books.append(ToAllTheBoys)
Books.append(TheGiver)
// MARK: - STEP THREE"
// Now we need to publish this data to the server.
// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books
let urlString = "https://uofd-tldrserver-develop.vapor.cloud/books"
// Create a URL request to publish the information, based upon the URL you
// just created.
let url = URL(string: urlString)!
// Add the body to the URL request you just created, by using JSONEncoder.
for _ in Books {
    var request = URLRequest(url: url)
    request.httpBody = try? JSONEncoder().encode(Books)
// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.
    request.httpMethod = "POST"
// Create a data task for publishing this element, and kick it off with a resume().
    let task = URLSession(configuration: .ephemeral).dataTask(with: request)
    task.resume()
}
// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.
