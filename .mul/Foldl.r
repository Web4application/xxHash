/**
 * Folds a 128-bit product into a 64-bit value via XOR.
 */
XXH3_fold128 : [128] -> [64]
XXH3_fold128 product = 
    let [high, low] = split product : [2][64]
    in high ^ low
