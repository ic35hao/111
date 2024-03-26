//  Class: axi_write_seq
//
class axi_write_seq extends uvm_sequence;
    `uvm_object_param_utils(axi_write_seq);
    
    //  Group: Variables
    const int no_of_trans;
    bit[7:0] id;
    axi_transaction trans;
    rand bit wstrb [][];

    //  Constructor: new
    function new(string name = "axi_write_seq");
        super.new(name);
        
        no_of_trans = 100;
    endfunction: new

    //  Task: body
    //  This is the user-defined task where the main sequence code resides.
    extern virtual task body();
    
endclass: axi_write_seq

task axi_write_seq::body();
    int cnt = 0;
    repeat(no_of_trans) begin
        id++;
        trans = axi_transaction::type_id::create("trans");
        trans.addr_val_align.constraint_mode(0);
        trans.addr_val_unalign.constraint_mode(0);
        trans.addr_val.constraint_mode(1);
        
        `uvm_info("DEBUG", $sformatf("axi_write_seq(), start_item id = %0d, \n:%0s", id, trans.sprint()), UVM_MEDIUM);
        start_item(trans);

        assert(trans.randomize());
        trans.addr = (cnt++) * 32'h100;

        trans.id = {1'b0, id};
        finish_item(trans);
        `uvm_info("DEBUG", $sformatf("axi_write_seq(), finish_item id = %0d", id), UVM_DEBUG);
        //trans.print();
        #10;
    end
endtask: body
