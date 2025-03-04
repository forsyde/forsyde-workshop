module Skeletons_FirstSteps where

import ForSyDe.Shallow

-- Test Vector
v_1 :: Vector Integer
v_1 = vector [1..16]

-- >>> v_1
-- <1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16>

-- Test Matrix 
m_1 :: Matrix Integer
m_1 = vector [ vector [1,2,3,4], vector [5,6,7,8], vector [9..12], vector [13..16]]

-- >>> m_1
-- <<1,2,3,4>,<5,6,7,8>,<9,10,11,12>,<13,14,15,16>>

-- Step 1 : Operations on vectors

-- Applying a function on all vector elements with 'mapV'
v_2 :: Vector Integer
v_2 = mapV (*10) v_1

-- >>> v_2 
-- <10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160>

-- Pairwise application of a function on two vectors
v_3 :: Vector Integer
v_3 = zipWithV (+) v_1 v_2

-- >>> v_3 
-- <11,22,33,44,55,66,77,88,99,110,121,132,143,154,165,176>

-- Reduction of a vector
vectorSum :: Integer
vectorSum = reduceV (+) v_1

-- >>> vectorSum
-- 136

vectorMax :: Integer
vectorMax = reduceV max v_1

-- >>> vectorMax
-- 16

-- Grouping with 'groupV'
m_2 :: Matrix Integer
m_2 = groupV 4 v_1

-- >>> m_2
-- <<1,2,3,4>,<5,6,7,8>,<9,10,11,12>,<13,14,15,16>>

-- Examples

-- Reducing a Matrix with 'reduceV'
m_3 :: Vector Integer
m_3 = mapV (reduceV max) m_2

-- >>> m_3 

--m_4 :: Integer
--m_4 = (mapV (reduceV max) . (mapV (reduceV max))) m_2

-- >>> m_4




