{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

import Crypto.Hash (hash, hashWith, SHA256(..), Digest) 
import Data.ByteString.UTF8 (fromString, toString)
import Data.Text.Encoding (encodeUtf8)
import Data.ByteString.Base64 (encode, decode)
import Control.Monad.Trans
import System.IO
import Data.Text as T
import Data.Time.Clock.POSIX (POSIXTime, getPOSIXTime)
import GHC.Generics
import Text.PrettyPrint
import Network.HTTP.Conduit
import qualified Data.Text.IO as TIO
import qualified Data.ByteString as B
import qualified Data.ByteArray as BA (pack, unpack)

main :: IO ()
main =  putStrLn "mutter"

type Hash   = Digest SHA256

data Trans  = Trans
  { from  ::  B.ByteString
  , to    ::  B.ByteString
  , bdata ::  B.ByteString
  } deriving (Show)

data Block  = Block 
  { depth ::  Int
  , stamp ::  Int
  , trans ::  Trans
  , bhash ::  Hash
  , phash ::  Maybe Hash
  , nonce ::  Maybe Int
  } deriving (Show, Generic)

genesisBlock  ::  Block
genesisBlock  = Block depth stamp trans bhash Nothing Nothing 
  where 
    depth = 0
    stamp = 0
    trans = Trans "Root" "World" ""
    bhash = hashWith SHA256 $ fromString phash
    phash = "0"

getStamp  :: IO Int
getStamp  = round <$> getPOSIXTime

hashBlock :: Block -> Digest SHA256
hashBlock (Block _ stamp _ bhash phash _) = hashWith SHA256 $ digest
  where 
    digest = fromString $ show stamp ++ show bhash ++ show phash

proofOfWork :: Int -> Maybe Int
proofOfWork pnum
  | pnum `mod` num == 0 = Just $ pnum
  | pnum `mod` num /= 0 = proofOfWork num
  | otherwise = Nothing
  where num = pnum + 1

getTrans :: IO Trans
getTrans = do
  putStr "From: " >> hFlush stdout
  from  <-  B.getLine
  putStr "To: " >> hFlush stdout
  to    <-  B.getLine
  putStr "Message: " >> hFlush stdout
  msg   <- B.getLine    
  return $ Trans from to msg 

mineBlock :: (MonadIO m) => Block -> m Block
mineBlock parentBlock = do 
  time    <- liftIO getStamp
  ltrans  <- liftIO getTrans
  let block = Block 
        { depth  = depth parentBlock + 1
        , stamp  = time
        , trans  = ltrans 
        , phash  = Just $ bhash parentBlock
        , bhash  = hashBlock parentBlock
        , nonce  = proofOfWork $ stamp parentBlock
        }
  return $ block



  
 

