-- https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md

module Main where

import Data.Aeson ( Value )
import Network.HTTP.Simple ( httpJSONEither, Response, JSONException, getResponseBody )

main :: IO ()
main = do
    response <- httpJSONEither "http://httpbin.org/get" :: IO (Response (Either JSONException Value))
    case getResponseBody response of
        Right body ->
            print body
        Left error ->
            print error
