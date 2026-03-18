# xxh3_verify.saw
import "XXH3_128.cry";

# Load the bitcode generated from the Rust crate
# Note: Ensure LTO is enabled to link dependencies into one bitcode file
m <- llvm_load_module "target/release/deps/xxhash_rust.bc";

# Verify the 128-bit one-shot function
let xxh3_128_setup = do {
    input_ptr <- llvm_alloc (llvm_array 1024 (llvm_int 8));
    input     <- llvm_symbolic "input" (llvm_array 1024 (llvm_int 8));
    llvm_points_to input_ptr (llvm_term input);

    # Call the Rust function: xxh3_128(input: &[u8]) -> u128
    # In LLVM, u128 may be represented as two i64 or one i128
    llvm_execute_func [input_ptr, llvm_int 1024];

    # Match against Cryptol's 128-bit spec
    llvm_return (llvm_term {{ XXH3_128_top input }});
};

llvm_verify m "xxh3_128" [] false xxh3_128_setup z3;
