{-# Language OverloadedStrings #-}

module Encryption where

import Data.ByteString as B
import Data.ByteString.Lazy.UTF8 as UTF8
import Data.Text as T
import Data.Text.Encoding
import Crypto.Hash as H
import Crypto.Cipher.AES as AES (AES256)
import Crypto.Cipher.Types as CT

import Lib 


getHash ::  B.ByteString  ->  Hash
getHash digest =  Just $ hashWith SHA256 digest


-- let's keep foldl for now if we want to add more items to the digest


--ecbEncryption ::  B.ByteString -> B.ByteString
--ecbEncryption plainText  = ecbEncrypt ctx plainText  
--  where
--    ctx = getCtx 

getCtx :: B.ByteString -> AES.AES256
getCtx  = undefined
  --either (error.show) cipherInit . makeKey
