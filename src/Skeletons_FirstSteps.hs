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
-- <4,8,12,16>

m_4 :: Integer
m_4 = (reduceV max . mapV (reduceV max)) m_2

-- >>> m_4
-- 16

-- Synchronous MoC and Skeletons

-- Definition of a few example vectors
v_4 :: Vector Integer
v_4 = vector [1..8]
v_5 :: Vector Integer
v_5 = vector [10,20..80]
v_6 :: Vector Integer
v_6 = vector [100,200..800]
v_7 :: Vector Integer
v_7 = vector [1000,2000..8000]

sv_1 :: Signal (Vector Integer)
sv_1 =signal [v_4, v_5, v_6, v_7]

-- >>> sv_1
-- {<1,2,3,4,5,6,7,8>,<10,20,30,40,50,60,70,80>,<100,200,300,400,500,600,700,800>,<1000,2000,3000,4000,5000,6000,7000,8000>}

-- A sychronous process that applies a function (+1) on a signal of vectors
sv_2 :: Signal (Vector Integer)
sv_2 = mapSY (mapV (+1)) sv_1

-- >>> sv_2

-- A synchronous process that reduces 
sv_3 :: Signal Integer
sv_3 = mapSY (reduceV (+)) sv_1

-- >>> sv_3 

-- The function 'unzipxSY' converts a signal of vectors into a vector of signals
sv_4 :: Vector (Signal Integer)
sv_4 = unzipxSY sv_1

-- >>> sv_4
-- <{1,10,100,1000},{2,20,200,2000},{3,30,300,3000},{4,40,400,4000},{5,50,500,5000},{6,60,600,6000},{7,70,700,7000},{8,80,800,8000}>

-- The function 'zipxSY' converts a vector of signals to a signal of vectors
sv_5 :: Signal (Vector Integer)
sv_5 = zipxSY sv_4

--- >>> sv_5 
-- {<1,2,3,4,5,6,7,8>,<10,20,30,40,50,60,70,80>,<100,200,300,400,500,600,700,800>,<1000,2000,3000,4000,5000,6000,7000,8000>}

-- Creating a vector of processes to model explicit parallelism
pn_1 :: (a -> a) -> Signal (Vector a) -> Signal (Vector a)
pn_1 f = zipxSY . mapV (mapSY f) . unzipxSY

-- >>> pn_1 (+1) sv_1
-- {<2,3,4,5,6,7,8,9>,<11,21,31,41,51,61,71,81>,<101,201,301,401,501,601,701,801>,<1001,2001,3001,4001,5001,6001,7001,8001>}

-- Reduction of a signal of vectorSum
pn_2 :: (a -> a -> a) -> Signal (Vector a) -> Signal a
pn_2 f = reduceV (zipWithSY f) . unzipxSY

-- >>> pn_2 max sv_1
-- {8,80,800,8000}

