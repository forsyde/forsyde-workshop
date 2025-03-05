module SY_Adaptive where

import ForSyDe.Shallow
    ( Signal, signal, zipWithSY, zipWith3SY, mapSY )

-- General idea for adaptive processes
--
-- Signals can carry functions
s_f1 :: Signal (Integer -> Integer)
s_f1 = signal [(+1), (*2), (+10)]

s_f2 :: Signal (Integer -> Integer -> Integer)
s_f2 = signal [(+), (*), (-)]

-- Function application
-- >>> (+1) $ 5
-- 6

-- Using function application to create an adaptive process
adaptiveSY :: Signal (a -> b) -> Signal a -> Signal b 
adaptiveSY = zipWithSY ($)

adaptive2SY :: Signal (a -> b -> c) -> Signal a -> Signal b -> Signal c
adaptive2SY = zipWith3SY ($)

-- >>> adaptiveSY (signal [(+1), (*10), (+10)]) (signal [1..3])
-- {2,20,13}

-- >>> adaptive2SY (signal [(+), (*), (-)]) (signal [1..3]) (signal [10,20,30])
-- {11,40,-27}


-- Example: Encoder/Decoder

encDec :: Signal Integer -> Signal Integer -> Signal Integer 
encDec s_key s_in = s_out where
  s_out  = p_dec s_fdec s_enc
  s_enc  = p_enc s_fenc s_in
  s_fenc = p_fenc s_key
  s_fdec = p_fdec s_key

p_dec :: Signal (Integer -> Integer) -> Signal Integer -> Signal Integer
p_dec = adaptiveSY

p_enc :: Signal (Integer -> Integer) -> Signal Integer -> Signal Integer
p_enc = adaptiveSY

p_fenc :: Signal Integer -> Signal (Integer -> Integer)
p_fenc = mapSY (+)

p_fdec :: Signal Integer -> Signal (Integer -> Integer)
p_fdec = mapSY f where
  f x y = y - x

-- >>> encDec (signal [1..10]) (signal [10,20..100])
-- {10,20,30,40,50,60,70,80,90,100}

