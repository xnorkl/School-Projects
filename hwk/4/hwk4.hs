-- Homework 4
-- Due: Oct. 25 by 5:15 pm
-- Course: CSCI-3300
-- Name: ADD-FULL-NAME-HERE
-- Total: 20 pt.

data BTree a =
   Empty
 | Node a (BTree a) (BTree a)
 deriving Show

-- Question 0 (5 pt).  In this problem define a function btree2list
-- that converts a BTree into a list. Some test cases are:
--   btree2list (Node 1 Empty Empty) = [1]
--   btree2list (Node 1 (Node 2 Empty Empty) Empty)))) = [1,2]
--   btree2list (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)) = [1,2,3]
--   btree2list (Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 5 (Node 6 Empty Empty) (Node 7 Empty Empty))) = [1,2,3,4,5,6,7]
--   btree2list (Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 5 (Node 6 Empty Empty) (Node 7 Empty (Node 8 Empty Empty)))) = [1,2,3,4,5,6,7,8]
-- It would help in understanding this problem by converting the trees
-- into graphical form, and then thinking about how the recursion
-- should proceed.
btree2list :: BTree a -> [a]
btree2list = undefined

-- Question 2 (5 pt).  Tree rotation is a common operation on trees.
-- In this problem define the rotateLeft function which takes a BTree
-- whose elements are of arbitrary type and rotates the input tree in
-- a counter-clockwise fashion.  Consider the following examples:
-- 
-- We write T -> rotateLeft(T): 
-- 
--        1 -> 1
--             
--        1    2
--        | -> |
--        2    1
--   
--     1          3    
--   /   \  ->  /   \  
--  2     3    1     2 
--    
--         1                 7
--      /     \           /     \
--     2       5    ->   1       4
--   /   \   /   \     /   \   /   \
--  3     4 6     7   2     3 5     6
-- 
-- Generalize on these examples, and use your insights to implement
-- the rotateLeft function.  Convert the trees above into trees using
-- BTree to test your rotateLeft :: BTree a -> BTree a           
rotateLeft :: BTree a -> BTree a
rotateLeft = undefined

-- Question 0 (10 pt).  The theme of this question is how to combine
-- pure code with monadic IO code.  We have several steps to this
-- question:
--
-- Step 1: Define the following function that converts a list of
-- integers into a list of strings.  If a number in the list is
-- divisable by 4 and 7, then replace it with BANG, if a number is
-- divisable by 4, but not 7, then replace it with BUZ, if a number is
-- divisable by 7, but not 4, then replace it with ZAP, otherwise
-- simply leave the number unchanged.
--
-- Suppose the list of numbers is as follows:
--    1,28,4,7,3,5
-- Then the following function should return:
--    [1,BANG,BUZ,ZAP,3,5]
--
processList :: [Integer] -> [String]
processList l = undefined

-- Step 2: This function simply prompts the user for series of digits
-- as strings using putStr, getLine and read one at a time, until the
-- user enters done, and then returns the list of the inputs converted
-- to integers.  For example running getDigs in GHCi should look like
-- this,
--
-- *Main> getDigs
-- Enter a digit: 1
-- Enter a digit: 2
-- Enter a digit: 3
-- Enter a digit: 4
-- Enter a digit: 65
-- Enter a digit: done
-- [1,2,3,4,65]
-- *Main>
--
-- Do not worry about proper error handling for this the read function
-- will throw an exception when the user tries to enter a non-digit
-- before entering done.
--
-- You will need to use the accumilator pattern and a helper function
-- to get this done.  Also, remember that this function *returns* a
-- list and does not *output* the list.
getDigs :: IO [Integer]
getDigs = undefined

-- Step 3: This function should take in a list of strings, and then
-- output the list to STDOUT. The list should be properly formated.
--
-- Examples in GHCi:
--
-- *Main> outputList ["1"]
-- 1
-- *Main> outputList ["1","2"]
-- 1, 2
-- *Main> outputList ["1","2","3"]
-- 1, 2, 3
-- *Main> outputList ["1","2","3","4"]
-- 1, 2, 3, 4
-- *Main> outputList ["1","2","3","4","5"]
-- 1, 2, 3, 4, 5
-- *Main> outputList ["1","2","3","4","5","6"]
-- 1, 2, 3, 4, 5, 6
outputList :: [String] -> IO ()
outputList = undefined

-- Step 4: Now we put all of the previous functions together in one
-- glorious main function.  This function should prompt the user for a
-- list of digits using getDigs, then process the list using
-- processList, and finally output the result using outputList.  This
-- function should do nothing else, and use no other functions.
main :: IO ()
main = undefined
