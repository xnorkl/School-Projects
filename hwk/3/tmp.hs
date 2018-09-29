-- Q0
import Data.Char
isInt :: Char -> Bool
--getInt = fromInteger . toInteger
--isInt c = (getInt(ord c - ord '0')::Word) < 10
isInt c 
   | c < minimum lc || c > maximum lc = False
   | otherwise = True
  where lc = ['0','1','2','3','4','5','6','7','8','9']
 

--ord '0' = 48
--ord '1' = 49, '2' = 50, ...
--ord '\t' = 9 ...which explains why I wanted to pull my hair out earlier...
--(Just ("",[])) s)

--tupleToList :: String -> Maybe [String]
--tupleToList s = case (foldl aux (Just ("",[])) s) of
--   Nothing -> Nothing
--   Just (s, acc) -> Just $ 


auxt :: Maybe (String, [String]) -> Char -> Maybe (String, [String])
auxt Nothing _ = Nothing
auxt (Just ((x:xs),ss)) c 
   | null xs = Just ("",[[]++[x]])
   | c == x = auxt (Just ((xs), ss)) c
   | c /= x = auxt (Just ((xs), [[]++[x]])) c


--trav :: (string, [String]) -> Char -> (String, [String])
--trav ((x:xs),[_]) c 
--   | c /= x = trav ((xs), [[]++[x]]) c
--   | c == x = trav ((xs), [[x]]) c

--auxt ::(String, [String]) -> Char -> Maybe (String, [String])
--auxt (([]),_) _ = Nothing
--auxt ((x:xs),[_]) c = case c of
--   ' ' -> Nothing
--   c -> auxt((xs),[[]++[x]])c



--aux' :: String -> Maybe (String)
--aux' (s:ss) = Just $ rev (s:ss) 
--aux' "" = Nothing

--rev ::(String,[String]) -> String
--rev = foldl (flip (:)) []

         
rmv :: String -> Char -> String
rmv [] c = []
rmv (s:ss) c 
   | s == c = rmv ss c
   | otherwise = s:rmv ss c

rvs :: String -> String
rvs = foldl (flip (:)) []

rmx :: String -> Char -> Maybe (String)
rmx [] c = Nothing
rmx (s:ss) c 
   | s == c = Just $ rmv (rvs ss) c
   | otherwise = Just $ s:rmv (rvs ss) c

--mby :: Maybe(String, [String]) -> Char -> Maybe(String, [String])
--mby [] c = Nothing
--mby acc c | c == head (acc) = Just $ foldr  acc
