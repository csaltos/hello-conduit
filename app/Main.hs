module Main where

import Data.Aeson
import Network.HTTP.Simple

-- SIMPLE GET

simpleGet :: IO ()
simpleGet = do
    response <- httpLbs "http://httpbin.org/get"
    print (getResponseBody response)

-- CUSTOM REQUEST

request = setRequestMethod "GET"
    $ setRequestHost "httpbin.org"
    $ setRequestPath "/get"
    $ defaultRequest

customRequest :: IO ()
customRequest = do
    response <- httpLbs request
    print (getResponseBody response)

-- SIMPLE HTTPS GET

simpleHttpsGet :: IO ()
simpleHttpsGet = do
    response <- httpLbs "https://httpbin.org/get"
    print (getResponseBody response)

-- CUSTOM HTTPS REQUEST

httpsRequest = setRequestMethod "GET"
    $ setRequestHost "httpbin.org"
    $ setRequestPath "/get"
    $ setRequestSecure True
    $ setRequestPort 443
    $ defaultRequest

customHttpsRequest :: IO ()
customHttpsRequest = do
    response <- httpLbs httpsRequest
    print (getResponseBody response)

-- GENERIC JSON GET

genericJsonGet :: IO ()
genericJsonGet = do
    response <- httpJSON "http://httpbin.org/get" :: IO (Response Value)
    print (getResponseBody response)

-- PARSED JSON GET

data CallInfo = CallInfo String String

instance FromJSON CallInfo where
    parseJSON (Object v) = do
        origin <- v .: "origin"
        url <- v .: "url"
        return (CallInfo origin url)

parsedJsonGet :: IO ()
parsedJsonGet = do
    response <- httpJSON "http://httpbin.org/get" :: IO (Response CallInfo)
    case getResponseBody response of
        CallInfo origin url ->
            print ("Requesting " ++ url ++ " from " ++ origin)

-- SIMPLE POST

simplePost :: IO ()
simplePost = do
    response <- httpLbs "POST http://httpbin.org/post"
    print (getResponseBody response)


-- GENERIC JSON POST

genericJsonPost :: IO ()
genericJsonPost = do
    response <- httpJSON "POST http://httpbin.org/post" :: IO (Response Value)
    print (getResponseBody response)

-- PARSED JSON POST

data User = User String String

instance ToJSON User where
    toJSON (User email fullname) = object
        [ "email" .= email
        , "fullname" .= fullname ]

parsedJsonPost :: IO ()
parsedJsonPost = do
    let user = User "test@test.com" "Test User"
    let request = setRequestBodyJSON user "POST http://httpbin.org/post"
    response <- httpJSON request :: IO (Response Value)
    print (getResponseBody response)

-- MAIN

main :: IO ()
main = do
    simpleGet
    customRequest
    simpleHttpsGet
    customHttpsRequest
    genericJsonGet
    parsedJsonGet
    simplePost
    genericJsonPost
    parsedJsonPost
