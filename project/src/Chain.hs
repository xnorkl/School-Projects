{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

module Chain where 

import Crypto.Hash 
import Data.ByteString.UTF8 (fromString, toString)
import Data.Text.Encoding (encodeUtf8)
import Data.ByteString.Base64 (encode, decode)
import Control.Monad.Trans
import System.IO
import Data.Text as T
import Data.Time.Clock.POSIX (POSIXTime, getPOSIXTime)
import GHC.Generics
import Text.PrettyPrint
import qualified Data.Text.IO as TIO
import qualified Data.ByteString as B

type Hash   = Digest SHA256
type Stamp  = Int

data Trans  = Trans
  { from  ::  B.ByteString
  , to    ::  B.ByteString
  , bdata ::  B.ByteString
  } deriving (Show)

data Block  = Block
  { depth ::  Int
  , stamp ::  Stamp
  , trans ::  Trans
  , bhash ::  Hash
  , phash ::  Maybe Hash
  , nonce ::  Int
  } deriving (Show, Generic)

genesisBlock  :: Block
genesisBlock  = Block depth stamp trans bhash Nothing nonce 
  where 
    depth = 0
    stamp = 0
    trans = Trans "Root" "World" ""
    bhash = hashWith SHA256 $ fromString $ Prelude.foldl (++) "" [show depth,phash]
    phash = "0"
    nonce = 0

getBlock  ::  Block -> Stamp -> Trans -> Block
getBlock  parentBlock@(Block depth' _ _ bhash' phash' nonce') stamp' trans' = newblock 
  where newblock = Block
          { depth = depth' + 1
          , stamp = stamp'
          , trans = trans'
          , phash = Just $ bhash'        
          , bhash = getHash parentBlock
          , nonce = proofOfWork $ nonce' 
          }

getHash :: Block -> Digest SHA256
getHash block@(Block depth stamp _ bhash phash _) = hashWith SHA256 $ digest
  where 
    digest = fromString $ Prelude.foldl (++) "" [show depth, show stamp, show phash, show bhash]

proofOfWork :: Int -> Int
proofOfWork pnum
  | pnum `mod` num == 0 = pnum
  | pnum `mod` num /= 0 = proofOfWork num
  where num = pnum + 1

------MonadIO...server?

getStamp  :: IO Int
getStamp  = round <$> getPOSIXTime

getTrans :: IO Trans
getTrans = do
  putStr "From: " >> hFlush stdout
  from  <-  B.getLine
  putStr "To: " >> hFlush stdout
  to    <-  B.getLine
  putStr "Message: " >> hFlush stdout
  msg   <- B.getLine    
  return $ Trans from to msg 


------MonadIO needs to be utilizied differently
mineBlock :: (MonadIO m) => Block -> m Block
mineBlock parentBlock = do 
  time    <- liftIO getStamp
  ltrans  <- liftIO getTrans
  let block = getBlock parentBlock time ltrans
  return $ block

  
 

