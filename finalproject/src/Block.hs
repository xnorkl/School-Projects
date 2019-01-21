{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Block where 

import            DataTypes
import            Data.Text.Encoding
import            GHC.Generics            hiding (to)
import            Data.Aeson              hiding (json)
import            Unsafe.Coerce           (unsafeCoerce)
import            Data.ByteString.UTF8    (fromString, toString)
import            Data.ByteString         (ByteString, append, pack, empty)
import qualified  Data.Word
import qualified  Data.ByteString.Base16  as Base16
import qualified  Crypto.Hash.SHA256      as SHA256
          
genesisBlock :: Block
genesisBlock = Block index' trans' stamp' bhash' phash' Nothing
    where 
      index'  = 0
      trans'  = [Trans "" "" ""]
      stamp'  = 0
      bhash'  = ""
      phash'  = "000000000000000000000000000000000"

mineBlock :: Block -> Int -> Block
mineBlock b@(Block i t s _ p _) n = 
    case head pow of
      '0' -> Block (i+1) t s bHash p (Just n)
      _   -> mineBlock b (n + 1)
    where 
      bHash = hashBlock b
      ctx = SHA256.updates SHA256.init (fmap fromString [bHash, show n, p])
      pow = toString . Base16.encode $ SHA256.finalize ctx

hashBlock :: Block -> String
hashBlock (Block index trans' _ bhash' phash' _) = toString $ Base16.encode digest
    where 
      fTrans  = foldr ((++) . show) "" trans'
      ctx     = SHA256.updates SHA256.init $ fmap fromString [fTrans, phash']
      digest  = SHA256.finalize ctx

addTrans  :: Block -> Trans -> Block
addTrans  (Block i ts s h p n) t = Block i (ts ++ [t]) s h p n

fetchMsg :: Block -> Trans
fetchMsg b@(Block _ t _ _ _ _) = last t

