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

m_2 :: Matrix Integer
m_2 = groupV 4 v_1

-- >>> m_2
-- <<1,2,3,4>,<5,6,7,8>,<9,10,11,12>,<13,14,15,16>>



