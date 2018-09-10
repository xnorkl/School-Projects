-- Homework 2:
--   Due: Thursday, Sept. 20 by 5:15pm.
--   Total Points: 20
--   Course: CSCI-3300
--   Name: FILL-IN-YOUR-NAME

-- 0. (2 pt) Define the function isIn that takes an element of a
-- list, and a list, and returns true if the element is a member of
-- the list or false otherwise.
isIn :: Eq a => a -> [a] -> Bool
isIn = undefined

-- 1. (3 pt) Define the intersper function which takes two lists, and
-- then constructs a new list where the first element of this new list
-- is the first element of the first argument, and the second element
-- is the first element of the second argument, and then the third is
-- the second element of the first argument, and the forth is the second
-- element of the second argument, and so on.  An example would be:
--   intersper [1,3] [2,4] = [1,2,3,4]

intersper :: [a] -> [a] -> [a]
intersper = undefined

-- 2. (15 pt) Text compression is important when storing large documents
-- on finite storage devices like harddrives.  In this problem we are
-- going to look at how we can write the run-length encoder for lists.
-- Run-length encoding is a common compression technique for text
-- files, but we can use it to compress the size of any list.  
-- 
-- First, lets consider an example.  The run-length encoding of the
-- string "committee" is 
-- [(1,'c'),(1,'o'),(2,'m'),(1,'i'),(2,'t'),(2,'e')].  Likewise, the
-- run length encoding of the list [1,2,2,3,4,5,5,5] is
-- [(1,1),(2,2),(1,3),(1,4),(3,5)].
--
-- So we can see that the run length-encoder takes in a list, and then
-- computes the list of ordered pairs where each ordered pair has as
-- its first projection the number of times the second projection
-- occurs consecutively in the list.  Our task is to define the
-- run-length encoder, rlEncode.  We can define this in three parts:
-- 
-- Part a.  Define the operation, op, that takes in an element of type
-- a, call it x, and a list of lists of type a, call it l, and then
-- computes the list where if the l is empty, op returns the list
-- containing the list containing x.  Then if the x is the same as the
-- head y, op returns the list where the head is the x consed onto y,
-- and the tail is the tail of y, otherwise simply cons the list
-- containing x to l.

op ::Eq a => a -> [[a]] -> [[a]]
op = undefined

-- Part b. Now visit the following site on Hoogle and read about the
-- function foldr, and then use that function to define the pack
-- function below using op from above:
--      http://hackage.haskell.org/package/base-4.7.0.1/docs/Prelude.html#v:foldr
--  The pack function takes a list of elements and returns a list of
--  lists of elements where each sublist is the list of consecutive
--  elements in the input list. A few examples are then: pack
--  [1,2,3,3,3,4] = [[1],[2],[3,3,3],[4]], and pack "Proof" =
--  [['P'],['r'],['o','o'],['f']].  The definition of pack should
--  consist of only a call to foldr, now that is elegant, right?

pack :: Eq a => [a] -> [[a]]
pack = undefined

-- Part c.  At this point we can define the rlEncode function using
-- the pack function, the map function, and an additional helper
-- function.  Define the additional helper function using the where
-- syntax, and then define rlEncode using the helper, map, and pack.
-- It is up to you to figure out what the helper function should do.
rlEncode :: Eq a => [a] -> [(Int,a)]
rlEncode l = undefined
