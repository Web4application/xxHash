/**
 * XXH3_mix128: The core 128-bit multiplication mixer.
 * Takes 16 bytes of data, 16 bytes of secret, and the 64-bit seed.
 */
XXH3_mix128 : [16][8] -> [16][8] -> [64] -> [128]
XXH3_mix128 data secret seed = 
    let dL = toLE (take`{8} data)
        dR = toLE (drop`{8} data)
        sL = toLE (take`{8} secret)
        sR = toLE (drop`{8} secret)
        
        // The "Wide" Multiplication: (64-bit ^ 64-bit) * (64-bit ^ 64-bit)
        // Result is 128 bits.
        product = (zext (dL ^ (sL + seed))) * (zext (dR ^ (sR - seed)))
    in product
