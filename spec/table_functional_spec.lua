local ftable = require("f.table")
describe("table functional", function()
    local array3 = {1,2,3}
    local array4 = {1,2,3,4}
    local array5 = {1,2,3,4,5}
    local array3r = {3,7,4}
    local array = {1,2,3}
    
    it("map", function()
        local target = {2,4,6}
        local t = ftable.map(array3, function(v) return v*2 end)
        assert.are.same({2,4,6}, t)
    end)
    
    it("filter", function()
        local t = ftable.filter(array3, function(v) return v % 2 == 0 end)
        assert.are.same({2}, t)
    end)
    
    it("find", function()
        local t = ftable.find(array3, function(v) return v % 2 == 0 end)
        assert.are.same(2, t)
    end)
    
    it("find_index", function()
        local t = ftable.find(array3, function(v) return v % 2 == 0 end)
        assert.are.same(2, t)
    end)
    
    it("index_of", function()
        local t = ftable.index_of(array3, 3)
        assert.are.same(3, t)
    end)
    
    it("reduce", function()
        local t = ftable.reduce(array3, function(accum, v, k, a)
            return accum + v
        end, 0)
        assert.are.same(6, t)
    end)
    
    it("push", function()
        local t = {1,2,3}
        ftable.push(t, 4)
        assert.are.same({1,2,3,4}, t)
    end)
    
    it("pop", function()
        local t = {1,2,3}
        ftable.pop(t)
        assert.are.same({1,2}, t)
    end)
    
    it("unshift", function()
        local t = {1,2,3}
        ftable.unshift(t, 4)
        assert.are.same({4,1,2,3}, t)
    end)
    
    it("shift", function()
        local t = {1,2,3}
        ftable.shift(t)
        assert.are.same({2,3}, t)
    end)
    
    it("reverse", function()
        local t = ftable.reverse({1,2,3})
        assert.are.same({3,2,1}, t)
    end)
    
    it("flat", function()
        local t = ftable.flat({1,2,3,{4,5},6})
        assert.are.same({1,2,3,4,5,6}, t)
        local t2 = ftable.flat({1,2,3,{4,{5,6}},6})
        assert.are.same({1,2,3,4,{5,6},6}, t2)
    end)
    
    it("flat_map", function()
        local t = ftable.flat_map({1,2,3,{4,5},6}, function(v) return v*2 end)
        assert.are.same({2,4,6,8,10,12}, t)
    end)
    
    it("slice", function()
        local t = ftable.slice({1,2,3,4,5}, 2)
        assert.are.same({2,3,4,5}, t)
        local t2 = ftable.slice({1,2,3,4,5}, 2, 4)
        assert.are.same({2,3,4}, t2)
    end)
    
    it("sort", function()
        local t = ftable.sort(array5, function(a,b) return b < a end)
        assert.are.same({5,4,3,2,1}, t)
    end)

    it("some", function()
        local t = ftable.some(array5, function(v) return v % 2 == 0 end)
        assert.are.True(t)
    end)

    it("every", function()
        local t = ftable.every(array5, function(v) return v % 2 == 0 end)
        assert.are.False(t)
        local t2 = ftable.every(array5, function(v) return type(v) == "number" end)
        assert.are.True(t2)
    end)

    it("concat", function()
        local t = ftable.concat(array3, array4)
        assert.are.same({1,2,3,1,2,3,4},t)
    end)

    it("fill", function()
        local t = ftable.fill({1,2,3}, 0)
        assert.are.same({0,0,0},t)
        local t = ftable.fill({1,2,3}, 0, 3)
        assert.are.same({1,2,0},t)
    end)

    it("includes", function()
        local t = ftable.includes(array3, 3)
        assert.are.True(t)
    end)

    it("join", function()
        local t = ftable.join(array3, ", ")
        assert.are.same("1, 2, 3",t)
    end)

    it("keys", function()
        local t = ftable.keys(array3)
        assert.are.same({1, 2, 3},t)
    end)

    it("values", function()
        local t = ftable.values(array3r)
        assert.are.same({3, 7, 4},t)
    end)

    it("length", function()
        local t = ftable.length(array3r)
        assert.are.equal(3,t)
    end)
    
  end)