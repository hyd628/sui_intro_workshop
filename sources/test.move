module sui_intro_workshop::haha {
    public fun plus(a: u32): u32 {
        a + 1
    }
}

module sui_intro_workshop::hahatest {
    use sui_intro_workshop::haha;
     #[test]
    fun test_neg_111() {
        //assert!()
        haha::plus(1u32);
    }
}