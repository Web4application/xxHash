/**
 * Property: XXH3_128 unseeded is identical to XXH3_128 with seed 0.
 * This holds because the secret derivation with 0 is an identity function.
 */
property XXH3_128_seed_0_equivalence {L} (fin L, L > 240) (input : [L][8]) =
    XXH3_128_unseeded input == XXH3_128_withSeed input 0
  where
    // Unseeded uses the constant DEFAULT_SECRET
    XXH3_128_unseeded in = XXH3_128_long in DEFAULT_SECRET
    
    // Seeded generates a custom secret from the seed first
    XXH3_128_withSeed in s = XXH3_128_long in (XXH3_generateSecret s)
