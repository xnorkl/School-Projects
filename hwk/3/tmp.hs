-- Q0
import Data.Char
isInt :: Char -> Bool
getInt = fromInteger . toInteger
isInt c = (getInt(ord c - ord '0')::Word) < 10
-- ord '0' = 48
-- ord '1' = 49, '2' = 50, ...
-- ord '\t' = 9 ...which explains why I wanted to pull my hair out earlier...


