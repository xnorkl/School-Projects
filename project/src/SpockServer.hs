{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Rank2Types        #-}

module SpockServer where

import           Block
import           Chain
import           DataTypes
import           Web.Spock.Config
import           Web.Spock.Core
import qualified Control.Monad.State as M

app :: IO ()
app = do
    liveChain <- runChain [genesisBlock ]
    runSpock 8080 $ spockT (runStateT liveChain) $ do
        get   "chain"     $ (M.lift getBlockchain)  >>= json
        get   "peek"      $ (M.lift getCurrent)     >>= json        
        get   "find"      $ (M.lift requestId)      >>= json
        get   "peekTrans" $ (M.lift $ getTrans)     >>= json
        post  "mineBlock" $ (M.lift mine)           >>= json
        post  "sendTrans" $ (M.lift $ requestInput) >>= json
              
