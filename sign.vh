`ifndef __SIGN_VH__
`define __SIGN_VH__

// 16-bit sign extend
// Extend __bit of __val to form a 16-bit result
`define SEXT(__val, __bit)  { {(16-__bit){__val[__bit]}}, __val }

`endif
