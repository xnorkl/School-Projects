module Server where 

import System.IO  as S
import Data.ByteString  as B
import Data.ByteString.Lazy.UTF8  as UTF8
import Data.Text  as T 
import Data.Time.Clock.POSIX (POSIXTime, getPOSIXTime)

import Lib 

getStamp  :: IO Int
getStamp  = round <$> getPOSIXTime

getTrans :: IO Trans
getTrans = do
  S.putStr "From: " >> hFlush stdout
  from  <-  S.getLine
  S.putStr "To: " >> hFlush stdout
  to    <-  S.getLine
  S.putStr "Message: " >> hFlush stdout
  msg   <-  S.getLine    
  return $ Trans 
      (UTF8.fromString from) 
      (UTF8.fromString to) 
      (UTF8.fromString msg)
    
getChain  ::  IO ()
getChain  = undefined
