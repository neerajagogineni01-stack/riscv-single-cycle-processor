module branch_logic(
    input branch,
    input zero,
    output pc_src
);

assign pc_src = branch & zero;

endmodule