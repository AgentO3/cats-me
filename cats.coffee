# Description:
#   Cats!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cat(s) me - A randomly selected cat
#   hubot cat(s) bomb me <number> - Cat explosion!
#
# Author:
#   AgentO3

url = 'http://thecatapi.com/api/images/get?format=src'

module.exports = (robot) ->
  robot.respond /cats?(?: me)?$/i, (msg) ->
    reqCats(url, msg)

  robot.respond /cats? bomb(?: me)?( \d+)?$/i, (msg) ->
    cats = msg.match[1] || 5
    (reqCats(url, msg)) for i in [1..cats]

reqCats = (url, msg, type) ->
  types = ['gif', 'jpg', 'png']
  type = msg.random types
  console.log type

  msg.http(url)
  .headers("User-Agent":"curl/7.21.4 (x86_64-apple-darwin12.2.0) libcurl/7.21.4 OpenSSL/0.9.8y zlib/1.2.5 libidn/1.20",
    "Accept":"*/*")
  .query(type: type)
  .get() (err, res, body) ->
    msg.send res.headers.location
