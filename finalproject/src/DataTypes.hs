{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Rank2Types        #-}

module DataTypes where

import            Data.Aeson            hiding (json)
import            GHC.Generics
import qualified  Control.Monad.State   as S

newtype RunStateT s m = RunStateT { runStateT :: forall a. S.StateT s m a -> m a }

type Blockchain = [Block]

data Trans = Trans 
            { from  ::  String
            , to    ::  String
            , tdata ::  String
            } deriving  (Generic, Show)

data Block = Block 
            { index ::  Int  
            , trans ::  [Trans]
            , stamp ::  Int
            , bhash ::  String 
            , phash ::  String 
            , nonce ::  Maybe Int
            } deriving  (Generic, Show)

instance ToJSON Trans
instance FromJSON Trans
instance ToJSON Block
instance FromJSON Block
