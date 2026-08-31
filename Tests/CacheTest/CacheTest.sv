class CacheTest extends uvm_test;
  `uvm_component_utils(CacheTest)
  CacheEnv Env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    Env = CacheEnv::type_id::create("Env", this);
  endfunction

  task run_phase(uvm_phase phase);
    CacheSequence Seq;
    Seq = CacheSequence::type_id::create("Seq");
    
    phase.raise_objection(this);
    Seq.start(Env.Agent.Sequencer);
    phase.drop_objection(this);
  endtask
endclass