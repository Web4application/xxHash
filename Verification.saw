# verification.saw
import "xxhash.cry"; # Load your Cryptol module

# 1. Load the compiled C/Rust code (LLVM bitcode)
m <- llvm_load_module "xxhash.bc";

# 2. Define the setup for the function to verify
let xxh3_accumulate_setup = do {
    # Allocate symbolic inputs
    accs_ptr   <- llvm_alloc (llvm_array 8 (llvm_int 64));
    stripe_ptr <- llvm_alloc (llvm_array 64 (llvm_int 8));
    secret_ptr <- llvm_alloc (llvm_array 64 (llvm_int 8));
    
    accs   <- llvm_symbolic "accs" (llvm_array 8 (llvm_int 64));
    stripe <- llvm_symbolic "stripe" (llvm_array 64 (llvm_int 8));
    secret <- llvm_symbolic "secret" (llvm_array 64 (llvm_int 8));

    llvm_points_to accs_ptr (llvm_term accs);
    llvm_points_to stripe_ptr (llvm_term stripe);
    llvm_points_to secret_ptr (llvm_term secret);

    # Execute function
    llvm_execute_func [accs_ptr, stripe_ptr, secret_ptr];

    # Assert that the result matches Cryptol's XXH3_accumulate
    llvm_points_to accs_ptr (llvm_term {{ XXH3_accumulate accs stripe secret }});
};

# 3. Run the proof using the Z3 solver
llvm_verify m "XXH3_accumulate" [] false xxh3_accumulate_setup z3;
print "Verification of XXH3_accumulate successful!";
