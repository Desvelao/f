local fstring = require("ftypes.string")
describe("table functional", function()
    -- tests go here
    local str1 = "lua"
    local str2 = "ftypes"
    local str3 = "use ftypes for lua"
    local str4 = "  Hello Lua  "
    local str5 = "Hello Lua  "
    local str6 = "  Hello Lua"
    
    it("starts_with", function()
        assert.are.True(fstring.starts_with(str1, "l"))
        assert.are.True(fstring.starts_with(str1, "lu"))
    end)
    
    it("ends_with", function()
        assert.are.True(fstring.ends_with(str1, "a"))
        assert.are.True(fstring.ends_with(str1, "ua"))
        assert.are.True(fstring.ends_with(str3, " for lua"))
    end)

    it("split", function()
        assert.are.same({"l","u","a"},fstring.split(str1, "."))
        assert.are.same({"use","ftypes","for", "lua"}, fstring.split(str3, "%S+"))
    end)

    it("concat", function()
        assert.are.equal("luaftypes",fstring.concat(str1, str2))
    end)

    it("match", function()
        assert.are.same({"l"},fstring.match(str1, "l"))
        assert.are.Nil(fstring.match(str1, "z"))
    end)

    it("rep", function()
        assert.are.equal("lualua",fstring.rep(str1, 2))
    end)

    it("trim", function()
        assert.are.equal("lualua",fstring.rep(str1, 2))
    end)

    it("trim_start", function()
        assert.are.equal("Hello Lua  ",fstring.trim_start(str4))
        assert.are.equal("Hello Lua  ",fstring.trim_start(str5))
        assert.are.equal("Hello Lua",fstring.trim_start(str6))
    end)

    it("trim_end", function()
        assert.are.equal("  Hello Lua",fstring.trim_end(str4))
        assert.are.equal("Hello Lua",fstring.trim_end(str5))
        assert.are.equal("  Hello Lua",fstring.trim_end(str6))
    end)

    it("pad_start", function()
        assert.are.equal("   lua",fstring.pad_start(str1, 6, " "))
        assert.are.equal("abalua",fstring.pad_start(str1, 6, "ab"))
    end)

    it("pad_end", function()
        assert.are.equal("lua   ",fstring.pad_end(str1, 6, " "))
        assert.are.equal("luaaba",fstring.pad_end(str1, 6, "ab"))
    end)

    it("includes", function()
        assert.are.True(fstring.includes(str1, "l"))
        assert.are.True(fstring.includes(str1, "ua"))
    end)

    it("index_of", function()
        assert.are.equal(2, fstring.index_of(str1, "ua"))
        assert.are.equal(3, fstring.index_of(str1, "a"))
    end)

    it("replace", function()
        assert.are.equal("zua", fstring.replace(str1, "l", "z"))
    end)
    
    
  end)