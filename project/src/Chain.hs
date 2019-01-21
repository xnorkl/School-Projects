{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Rank2Types        #-}

module Chain where

import            Block
import            DataTypes
import            System.IO
import            Data.IORef
import            Data.String           (fromString)
import            Data.Time.Clock.POSIX 
import qualified  Control.Monad.State   as S
import qualified  Control.Monad.Trans   as T

-- IO interfaces

mine :: (T.MonadIO m) => S.StateT Blockchain m Blockchain
mine = T.liftIO ioStamp >>= retMine

requestInput :: (T.MonadIO m) => S.StateT Blockchain m Blockchain
requestInput = T.liftIO ioTrans >>= mkTrans

requestId :: (T.MonadIO m) => S.StateT Blockchain m Blockchain
requestId =  T.liftIO ioBlockId >>= getBlockhash

ioStamp  :: IO Int
ioStamp  = round <$> getPOSIXTime

ioTrans :: IO Trans
ioTrans = do
  putStr "From: "     >> hFlush stdout
  from  <-  getLine 
  putStr "To: "       >> hFlush stdout
  to    <-  getLine
  putStr "Message: "  >> hFlush stdout
  msg   <-  getLine    
  return $ Trans from to msg

ioBlockId :: IO String
ioBlockId = do
  putStr "Enter a block id: " >> hFlush stdout
  input <- getLine
  return input

-- State interfaces

runChain :: s -> IO (RunStateT s IO)
runChain s0 = do
    r <- newIORef s0
    return $ RunStateT $ \act -> do
        s <- readIORef r
        (x, s') <- S.runStateT act s
        atomicModifyIORef' r $ const (s', x)

retMine :: (Monad m) => Int -> S.StateT Blockchain m Blockchain
retMine stamp = do
    bChain <- S.get 
    let mineb = mineBlock (head bChain) 0 
    let newbh = Block (index mineb) [] stamp "" (hashBlock mineb) Nothing
    let newbc = ([newbh, mineb] ++ (tail bChain))
    S.put newbc
    return [mineb]

getCurrent :: (Monad m) => S.StateT Blockchain m Blockchain
getCurrent = do
    bChain <- S.get
    return $ [head bChain]

getBlockhash :: (Monad m) => String -> S.StateT Blockchain m Blockchain
getBlockhash h = do
    bChain <- S.get
    return $ filter (\b -> (hashBlock b) == h) bChain

mkTrans :: (Monad m) => Trans -> S.StateT Blockchain m Blockchain
mkTrans trans = do
    bChain <- S.get
    let header = addTrans (head bChain) trans  
    let newbcS = ([header] ++ (tail bChain))
    S.put newbcS
    return [header]

getTrans  :: (Monad m) => S.StateT Blockchain m Trans
getTrans  = do
  bChain <- S.get
  let header = fetchMsg $ head bChain
  return header

getBlockchain :: (Monad m) => S.StateT Blockchain m Blockchain
getBlockchain = S.get >>= return




