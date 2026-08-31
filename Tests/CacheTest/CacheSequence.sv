class CacheSequence extends uvm_sequence #(CacheItem);

  `uvm_object_utils(CacheSequence)

  function new(string name = "CacheSequence");
    super.new(name);
  endfunction

  task body();
    repeat(10) begin
      req = CacheItem::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask

endclass