include("memory_helpers.jl")

import OpenCL 
const cl = OpenCL

macro throws_pred(ex) FactCheck.throws_pred(ex) end 

facts("OpenCL.Memory") do

    function create_test_buffer()
        ctx = cl.create_some_context()
        queue = cl.CmdQueue(ctx)
        testarray = zeros(Float32, 1000000)
        buf = cl.Buffer(Float32, ctx, (:rw, :copy), hostbuf=testarray)
        return nothing
    end

    context("OpenCL.Memory Buffer") do
        for device in cl.devices()

            @fact run_mtest("Buffer creation", create_test_buffer) => true
        end
    end
end
