{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Rank2Types        #-}

module Server where

import           Block
import           Chain
import           DataTypes
import           Web.Spock.Config
import           Web.Spock.Core
import qualified Control.Monad.State as S

app :: IO ()
app = do
    liveChain <- runChain [genesisBlock ]
    runSpock 8080 $ spockT (runStateT liveChain) $ do
        get   "chain"     $ (S.lift getBlockchain)  >>= json
        get   "peak"      $ (S.lift getCurrent)     >>= json        
        get   "find"      $ (S.lift requestId)      >>= json
        get   "peakTrans" $ (S.lift $ getTrans)     >>= json
        post  "mineBlock" $ (S.lift mine)           >>= json
        post  "sendTrans" $ (S.lift $ requestInput) >>= json
              
