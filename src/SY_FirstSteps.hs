module SY_FirstSteps where

import ForSyDe.Shallow

data Direction = Up | Reset deriving Show

-- Define a Test Signal
s_1 :: Signal Direction
s_1 = signal [Up, Up, Up, Reset, Up]

-- >>> s_1
-- {Up,Up,Up,Reset,Up}

-- Step 1: Create Netlist
counter :: Signal Direction -> Signal Integer
counter dir = out where
  nextstate = p_1 state dir 
  state     = p_2 nextstate
  out       = p_3 state dir 

-- Step 2: Create Processes with Process Constructors
p_1 :: Signal Integer -> Signal Direction -> Signal Integer
p_1 = comb2SY count
p_2 :: Signal Integer -> Signal Integer
p_2 = delaySY 0
p_3 :: Signal Integer -> Signal Direction -> Signal Integer
p_3 = comb2SY output

-- Step 3: Specify Functions
count :: Integer -> Direction -> Integer
count x Up    = x + 1
count _ Reset = 0

output :: Integer -> Direction -> Integer
output state Up    = state + 1
output _     Reset = 0

-- >>> counter s_1 
-- {1,2,3,0,1}

-- Step 4: Counter med Mealy process constructor
counter' :: Signal Direction -> Signal Integer
counter' = mealySY count output 0

-- >>> counter' s_1
-- {1,2,3,0,1}
