{-# Language OverloadedStrings #-}

module Chain where 

import Control.Monad.Trans
import Control.Comonad.Cofree
import System.IO
import GHC.Generics
import Data.ByteString as B 
import Data.ByteArray as BA
import Data.Sequence as Seq 
import Data.Data
import Data.ByteString.Lazy.UTF8 as UTF8


import Encryption
import Server
import Lib 

----Block Construction----

genesisBlock  :: Block
genesisBlock  = Block depth stamp trans Nothing 
  where 
    depth = 0
    stamp = 0
    trans = Trans  
              (UTF8.fromString "Root") 
              (UTF8.fromString  "World") 
              (UTF8.fromString  "Initial Transaction")
    bhash = getHash $ squashTrans trans
    phash = Nothing

newBlock  ::  Chain -> Stamp -> Trans -> Block
newBlock chain time' trans'  = newblock
  where
    newblock  = Block
      { depth = Seq.length chain + 1
      , stamp = time'
      , trans = trans'
      , phash = getHash $ squashTrans trans'
      }
 

mineBlock :: (MonadIO m) => chain -> m Chain
mineBlock chain  = do
  time    <-  liftIO getStamp
  ltrans  <-  liftIO getTrans
  let block = newBlock chain time ltrans
  let currentchain = chain |> block 
  return $ currentchain

 
----Chain Construction and Interface----

genesisChain  ::  Chain
genesisChain  = Seq.singleton genesisBlock

checkChain  ::  Chain
checkChain = undefined 

getLastBlock  ::  Chain -> Block
getLastBlock  chain = Seq.index chain (Seq.length chain - 1)

getChainSize  ::  Chain -> Maybe Int
getChainSize chain 
  | Seq.length chain == 0 = Nothing
  | otherwise = Just $ Seq.length chain

growChain ::  Chain
growChain = undefined

squashTrans ::  Trans -> B.ByteString
squashTrans trans'  = fromString $ show trans' 

getMHash  ::  Block -> UTF8.ByteString
getMHash  block@(Block _ _ _ phash') = UTF8.fromString $ show phash'

getMerkl  ::  Chain -> Hash
getMerkl  chain = undefined





  
  
 

