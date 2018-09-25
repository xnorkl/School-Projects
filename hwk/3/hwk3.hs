-- Homework 3:
--   Due: Friday, Sept. 28th by 11:59pm.
--   Total Points: 20
--   Course: CSCI-3300
--   Name: FILL-IN-YOUR-NAME

-- In this assignment you will write a parser for tuples.  That is,
-- given a string "10,22,31,42" the parser will return a list of
-- integers [10,22,31,42].  We will break this problem up into two
-- steps.

-- Question 0 (10 pt).  The first step will require you to write two
-- functions, the first, a predicate on characters that is true when
-- the input character is an integer, but false otherwise.

isInt :: Char -> Bool
isInt c = if c == fromInteger c
-- Second, you are required to fill in the following auxiliary
-- function to the tupleToList function that parses a single character
-- given an accumulator.
--
-- The type of the accumulator is Maybe (String,[String]), and if it
-- is Nothing, then we return Nothing to indicate a parse error, and
-- in fact, anytime something does not parse, Nothing should be
-- returned.
--
-- If the accumulator is (Just (n,ns)), then n accumulates the symbols
-- of the current integer being parsed, but when a comma is hit during
-- parsing, we add n to ns, because we have all of its symbols.
--
-- Using this intuition define the aux function below, but first, work
-- out how one would parse "42,24,321" on paper.
aux :: Maybe (String,[String]) -> Char -> Maybe (String,[String])
aux acc c = undefined

-- Finally, fill in the undefined part of the following function that
-- should return the fully parsed input string using reverse and list
-- cons.
tupleToList :: String -> Maybe [String]
tupleToList s = case (foldl aux (Just ("",[])) s) of
                  Nothing -> Nothing
                  Just (s,acc) -> Just $ undefined


-- (10pt) Using tupleToList and the read function write the following
-- function that parses the input string, and then converts the parsed
-- list into a list of Haskell integers.
parseTuples :: String -> Maybe [Int]
parseTuples s = case (tupleToList s) of
                  Nothing -> undefined
                  Just l -> undefined
