XXH3_64_merge : [8][64] -> [64][8] -> [64]
XXH3_64_merge accs secret = avalanche (foldl mixing_step 0 (zip accs secret_blocks))
  where
    secret_blocks = split secret : [8][8][8]
    
    // The core mixing step for the final merge
    mixing_step state (acc, s_block) = 
        state ^ xxh3_mix (acc ^ toLE s_block)
        
    xxh3_mix x = (x ^ (x >> 33)) * PRIME64_2
