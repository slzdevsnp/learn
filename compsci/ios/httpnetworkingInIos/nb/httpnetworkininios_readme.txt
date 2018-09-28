title: http networking in ios

## chap 1   Intro

  chatcave chatserver buit in node.js  installable written by author

  * care for UX if network is unavailable
  * key elements of rest
    * unlimited set of nouns
    * limited set of verbs
    * urls describe hierarchy
    * multiple representation
    * orthogonal

    chatcave resources:
    Rooms
    GET /rooms
    POST /rooms  (given correct body of the request, will be able to create a new room)
    GET /rooms/:id
    DELETE /rooms/:id

    Chatroom members
    GET /rooms/:id/chatters
    PUT /rooms/:id/chatters:id
    DELETE /rooms/:id/chatters/:id

    Messages
    GET /rooms/:id/messages
    POST /rooms/:id/messages

    xcode ChatCave app project stubbed

    view design

    in this demo app the author treats authentication as an exceptional navigational loop

    object serialization


    #### design goals
      block-based callbacks
      use domain-model object
      abstract away details
      can be cancelled
      encapsulate remote access
      callbacks

    ##### chat cave server node.js installation
    >brew install node
    >bruw upgrade ruby
    >brew install node

    >cd chatcave_server
    >npm install  # npm node package manager , this adds 16 MB of dependencies
    >./app.js  # to start the server
    in the browser
    http://localhost:3000
    start with Sign Up! link
    create new user (users are persistent)

## chap 2  Networking with NSURLConnection

## chap 3 Authentication & Caching

## chap 4 Networking with NSURLSession

## chap 5 Background Tasks with NSURLSession

## chap 6 Debugging tools & Techniques

## chap 7 Conclusion
