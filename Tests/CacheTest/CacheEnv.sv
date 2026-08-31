class CacheEnv extends uvm_env;

    `uvm_component_utils(CacheEnv)
    CacheAgent      Agent;
    CacheScoreboard Scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Agent = CacheAgent::type_id::create("Agent", this);
        Scoreboard = CacheScoreboard::type_id::create("Scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        Agent.Monitor.ap.connect(Scoreboard.item_collected_export);
    endfunction
    
endclass