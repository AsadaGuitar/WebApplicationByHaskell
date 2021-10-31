
module Main where

import qualified Codec.Binary.UTF8.String as UTF8
import qualified Data.ByteString as DB

import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.Wai as Wai
import qualified Network.HTTP.Types as HTypes

main :: IO()
main = Warp.run 8000 helloApp

helloApp :: Wai.Application
helloApp req send = let msg = toByteString "Hello Wai !!!!"
    in send $ Wai.responseBuilder HTypes.status200 [] msg
    
toByteString :: String -> DB.ByteString
toByteString s = DB.pack $ UTF8.encode s

