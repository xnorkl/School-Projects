{-# LANGUAGE  DeriveGeneric #-}
{-# LANGUAGE  TypeFamilies  #-}
{-# LANGUAGE  OverloadedStrings   #-}
{-# LANGUAGE  ScopedTypeVariables #-}
module Lib where

import System.IO as S
import Data.Text as T
import Data.Text as TIO
import Data.Sequence as Seq
import Data.Data as Dat
import Data.ByteString as B 
import Data.ByteArray as BA
import Data.ByteString.Base64 as B64 (encode, decode)
import Data.ByteString.Lazy.UTF8 as UTF8
import Data.Bits as Bit (xor)
import Control.Monad.Trans
import GHC.Generics
import Crypto.Hash
import Crypto.Cipher.AES (AES256)
import Crypto.Cipher.Types
import Crypto.Error

type Stamp  = Int
type Hash   = Maybe (Digest SHA256)
type Chain  = Seq Block 

data Trans  = Trans
  { from  ::  UTF8.ByteString
  , to    ::  UTF8.ByteString
  , bdata ::  UTF8.ByteString
  } deriving (Show)

data Block  = Block
  { depth ::  Int
  , stamp ::  Stamp
  , trans ::  Trans
  , phash ::  Hash
  } deriving (Show, Generic)


   
