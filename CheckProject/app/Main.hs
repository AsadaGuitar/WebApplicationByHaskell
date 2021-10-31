module Main where

import qualified Codec.Binary.UTF8.String as UTF8

import qualified Data.Text as T

import qualified Data.ByteString as DB
import qualified Data.Binary.Builder as DBB

import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.Wai as Wai
import qualified Network.HTTP.Types as HTypes


main :: IO ()
main =  Warp.run 8000 startServer

startServer :: Wai.Application
startServer req = router (Wai.pathInfo req) req

router :: [T.Text] -> Wai.Application
router txts req send
    | txts == [T.pack "foo"] = fooApp req send
    | txts == [T.pack "boo"] = booApp req send
    | otherwise              = helloApp req send

echoApp :: [T.Text] -> Wai.Application
echoApp txts req send 
    = send $ Wai.responseBuilder HTypes.status200 [] $ strGetBuilder $ T.unpack (head txts)

notFoundApp :: Wai.Application
notFoundApp req send
    = send $ Wai.responseBuilder HTypes.status200 [] $ strGetBuilder "not found."
    

booApp :: Wai.Application
booApp req send 
    = send $ Wai.responseBuilder HTypes.status200 [] $ strGetBuilder "boooo !"
   
fooApp :: Wai.Application
fooApp req send 
    = send $ Wai.responseBuilder HTypes.status200 [] $ strGetBuilder "foooo !"
   
helloApp :: Wai.Application
helloApp req send 
    = send $ Wai.responseBuilder HTypes.status200 [] $ strGetBuilder "Hello World !"

strGetBuilder :: String -> DBB.Builder
strGetBuilder str = DBB.fromByteString $ toByteString str

toByteString :: String -> DB.ByteString
toByteString s = DB.pack $ UTF8.encode s
